import type React from 'react'
import { useEffect, useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { ArrowLeft, User, Users, Clock, Check, AlertCircle, Send } from 'lucide-react'
import { useToast } from '../../hooks/use-toast'
import { WordDictionary } from '../../lib/dict'
import { useScaffoldWriteContract } from '../../hooks/scaffold-stark/useScaffoldWriteContract'
import { useGameStore } from '../../stores/gameStore'
import { BigNumberish } from 'starknet'
import { generateProof } from '../../lib/generate-proof-utils'
import vkUrl from '../../assets/vk.bin?url'
import { useGameStorage } from '../../hooks/use-game-storage'
import { useScaffoldReadContract } from '../../hooks/scaffold-stark/useScaffoldReadContract'
import { extractKnownErrorMessage } from '../../lib/error'
import { useDictionary } from '../../context/dictionary'

interface GameBoardProps {
    guesses: string[]
    hb: Array<{ hit: number; blow: number; submitted: boolean }>
    opponentGuesses: string[]
    opponentHb: Array<{ hit: number; blow: number; submitted: boolean }>
    isPlayerTurn: boolean
    round: number
    playerRole: 'creator' | 'opponent' | null
    playerAddress: string
    onBack: () => void
    playSound: (type: 'play' | 'finish') => void
}

type TabType = 'combined' | 'opponent' | 'you'

export default function GameBoard({
    guesses,
    hb,
    opponentGuesses,
    opponentHb,
    isPlayerTurn,
    round,
    playerRole,
    playerAddress,
    onBack,
    playSound
}: GameBoardProps) {
    const [activeTab, setActiveTab] = useState<TabType>('combined')
    const [inputGuess, setInputGuess] = useState('')
    const [isSubmittingGuess, setIsSubmittingGuess] = useState(false)
    const [guess, setGuess] = useState<number[]>([])
    const [inputError, setInputError] = useState<string | null>(null)
    const [isProving, setIsProving] = useState<boolean>(false)
    const [proof, setProof] = useState<BigNumberish[]>([])
    const { toast } = useToast()
    const { gameId } = useGameStore()
    const { getGameData } = useGameStorage('game-data', Number(gameId))
    const [shouldSubmitGuess, setShouldSubmitGuess] = useState(false)
    const [shouldSubmitProof, setShouldSubmitProof] = useState(false)

    const dict = useDictionary()

    const maxAttempts = 10

    const firstEmptyIndex = opponentGuesses.findIndex(g => g === '')
    const isLastHBSubmitted =
        firstEmptyIndex < 0 ? true : opponentHb[firstEmptyIndex - 1]?.submitted

    const { sendAsync: submitGuess } = useScaffoldWriteContract({
        contractName: 'Mastermind',
        functionName: 'submit_guess',
        args: [gameId, guess]
    })

    const { sendAsync: submitHBProof } = useScaffoldWriteContract({
        contractName: 'Mastermind',
        functionName: 'submit_hit_and_blow_proof',
        args: [gameId, proof]
    })

    const { data: getGameSolutionHash } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_solution_hash',
        args: [gameId, playerAddress]
    })

    // Validate the input guess
    const validateGuess = (guess: string): string | null => {
        if (guess.length !== 4) {
            return 'Guess must be 4 letters'
        }

        if (!/^[A-Za-z]+$/.test(guess)) {
            return 'Only letters are allowed'
        }

        // Check for unique letters
        const uniqueLetters = new Set(guess.split(''))
        if (uniqueLetters.size !== 4) {
            return 'All letters must be unique'
        }

        if (!dict.hasWord(guess)) {
            return 'Guess must be in the dictionary'
        }

        return null
    }

    // Handle input change
    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const value = e.target.value.toUpperCase().slice(0, 4)
        setInputGuess(value)

        if (value.length === 4) {
            const error = validateGuess(value)
            setInputError(error)
        } else {
            setInputError(null)
        }
    }

    // Handle guess submission
    const handleSubmitGuess = async (e: React.FormEvent) => {
        e.preventDefault()
        setIsSubmittingGuess(true)
        playSound('play')

        if (!isPlayerTurn) {
            toast({
                title: 'Not your turn',
                description: 'Please wait for your opponent to make their move',
                variant: 'destructive'
            })
            setIsSubmittingGuess(false)
            return
        }

        const error = validateGuess(inputGuess)
        if (error) {
            setInputError(error)
            toast({
                title: 'Invalid guess',
                description: error,
                variant: 'destructive'
            })
            setIsSubmittingGuess(false)
            return
        }

        const guessArray = inputGuess.split('').map(letter => letter.charCodeAt(0))
        setGuess(guessArray)
        setShouldSubmitGuess(true)
    }

    const handleSubmitHBProof = async (guess: string) => {
        setIsProving(true)
        playSound('play')

        try {
            const { hit, blow } = calculateHitsAndBlows(guess)
            const guessArray = guess.split('').map(letter => letter.charCodeAt(0))

            const input = {
                guess: guessArray,
                solution: getGameData(gameId as number)?.solution,
                salt: getGameData(gameId as number)?.salt,
                solution_hash: getGameSolutionHash.toString(),
                num_hit: hit,
                num_blow: blow
            }

            const { callData } = await generateProof(input, vkUrl)
            setProof(callData)
            setShouldSubmitProof(true)
        } catch (error: any) {
            toast({
                title: 'Error submitting proof',
                description: extractKnownErrorMessage(error) || 'Unexpected error occurred.',
                variant: 'destructive'
            })
            setIsProving(false)
        }
    }

    // Calculate hits and blows from hb
    const calculateHitsAndBlows = (guess: string) => {
        if (!guess) return { hit: 0, blow: 0 }
        let hit = 0
        let blow = 0

        const solution = getGameData(gameId as number)?.solution as number[]
        const solutionCopy = [...solution]
        const guessArray = guess.split('').map(s => s.charCodeAt(0))
        const guessCopy = [...guessArray]

        // First pass: count hits
        for (let i = 0; i < 4; i++) {
            if (guessCopy[i] === solutionCopy[i]) {
                hit++
                // Mark as matched
                guessCopy[i] = solutionCopy[i] = -1
            }
        }

        // Second pass: count blows (correct number, wrong position)
        for (let i = 0; i < 4; i++) {
            if (guessCopy[i] !== -1) {
                const index = solutionCopy.indexOf(guessCopy[i])
                if (index !== -1) {
                    blow++
                    solutionCopy[index] = -1 // mark matched to avoid duplicate count
                }
            }
        }

        return { hit, blow }
    }

    useEffect(() => {
        const submit = async () => {
            if (!shouldSubmitGuess || !guess) return

            const res = await submitGuess()

            if (res) {
                setInputGuess('')
                setGuess([])
                toast({
                    title: 'Guess submitted',
                    description: 'Your guess has been submitted successfully.'
                })
            }

            setShouldSubmitGuess(false)
            setIsSubmittingGuess(false)
        }

        submit()
    }, [guess, shouldSubmitGuess])

    useEffect(() => {
        const submit = async () => {
            if (!shouldSubmitProof || !proof) return

            const res = await submitHBProof()

            if (res) {
                toast({
                    title: 'Proof submitted',
                    description: 'Your hit and blow proof has been submitted successfully.'
                })
            } else {
                toast({
                    title: 'Error submitting proof',
                    description: 'Failed to submit your hit and blow proof.',
                    variant: 'destructive'
                })
            }

            setShouldSubmitProof(false)
            setIsProving(false)
        }

        submit()
    }, [proof, shouldSubmitProof])

    // Render a single guess with hit/blow counts
    const renderGuess = (
        guess: string,
        oppnentHb: { hit: number; blow: number; submitted: boolean }
    ) => {
        const isMyTurnToProve = Number(round) % 2 === (playerRole === 'creator' ? 1 : 0)
        return (
            <div className="flex items-center justify-between mb-4 p-3 bg-white dark:bg-gray-800 rounded-lg border-2 border-gray-300 dark:border-gray-700">
                <div className="flex items-center">
                    <div className="text-lg font-mono font-bold mr-4">{guess}</div>
                </div>

                {oppnentHb.submitted ? (
                    <div className="flex items-center space-x-4">
                        <div className="flex items-center">
                            <div className="w-6 h-6 rounded-full bg-retro-green flex items-center justify-center text-white font-bold mr-1">
                                {oppnentHb.hit}
                            </div>
                            <span className="text-sm">Hits</span>
                        </div>
                        <div className="flex items-center">
                            <div className="w-6 h-6 rounded-full bg-retro-yellow flex items-center justify-center text-black font-bold mr-1">
                                {oppnentHb.blow}
                            </div>
                            <span className="text-sm">Blows</span>
                        </div>
                    </div>
                ) : guess && isMyTurnToProve ? (
                    <button
                        onClick={() => handleSubmitHBProof(guess)}
                        className="retro-button retro-button-outline py-1 px-3 text-sm flex items-center mt-1"
                        disabled={isProving || !isPlayerTurn}
                    >
                        {isProving ? (
                            <span className="flex items-center">Proving ...</span>
                        ) : (
                            <span className="flex items-center">
                                <Check className="mr-2 h-3 w-3" />
                                Prove
                            </span>
                        )}
                    </button>
                ) : (
                    <div className="flex items-center space-x-4">
                        {[...Array(2)].map((_, idx) => (
                            <div key={idx} className="flex items-center">
                                <div className="w-6 h-6 rounded-full border-2 border-dashed border-gray-300 dark:border-gray-700 bg-retro-dark flex items-center justify-center font-bold text-gray-300 dark:text-gray-700">
                                    ?
                                </div>
                            </div>
                        ))}
                    </div>
                )}
            </div>
        )
    }

    // Render the combined view
    const renderCombinedView = () => {
        return (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {/* Player's board */}
                <div className="retro-game-board mb-4">
                    <div className="flex justify-center items-center mb-4">
                        <div className="retro-badge retro-badge-primary flex items-center">
                            <User className="mr-2 h-4 w-4" />
                            <span>Your Guesses</span>
                        </div>
                    </div>

                    {/* Player's previous guesses */}
                    {guesses.map((guess, guessIndex) => (
                        <div key={`guess-${guessIndex}`}>{renderGuess(guess, hb[guessIndex])}</div>
                    ))}
                </div>

                {/* Opponent's board */}
                <div className="retro-game-board mb-4">
                    <div className="flex justify-center items-center mb-4">
                        <div className="retro-badge retro-badge-secondary flex items-center">
                            <Users className="mr-2 h-4 w-4" />
                            <span>Opponent's Guesses</span>
                        </div>
                    </div>

                    {/* Opponent's previous guesses */}
                    {opponentGuesses.map((guess, guessIndex) => (
                        <div key={`opponent-guess-${guessIndex}`} className="mb-4">
                            {renderGuess(guess, opponentHb[guessIndex])}
                        </div>
                    ))}
                </div>
            </div>
        )
    }

    // Render the opponent view
    const renderOpponentView = () => {
        return (
            <div className="retro-game-board mb-4 max-w-md mx-auto">
                <div className="flex justify-center items-center mb-4">
                    <div className="retro-badge retro-badge-secondary flex items-center">
                        <Users className="mr-2 h-4 w-4" />
                        <span>Opponent's Guesses</span>
                    </div>
                </div>

                {/* Opponent's previous guesses */}
                {opponentGuesses.map((guess, guessIndex) => (
                    <div key={`opponent-guess-${guessIndex}`} className="mb-4">
                        {renderGuess(guess, opponentHb[guessIndex])}
                    </div>
                ))}
            </div>
        )
    }

    // Render the player view
    const renderPlayerView = () => {
        return (
            <div className="retro-game-board mb-4 max-w-md mx-auto">
                <div className="flex justify-center items-center mb-4">
                    <div className="retro-badge retro-badge-primary flex items-center">
                        <User className="mr-2 h-4 w-4" />
                        <span>Your Guesses</span>
                    </div>
                </div>

                {/* Player's previous guesses */}
                {guesses.map((guess, guessIndex) => (
                    <div key={`guess-${guessIndex}`} className="mb-4">
                        {renderGuess(guess, hb[guessIndex])}

                        <div className="flex justify-center mt-1 text-xs">
                            <div className="flex gap-4">
                                <span className="flex items-center">
                                    <div className="w-3 h-3 rounded-full bg-retro-green mr-1"></div>
                                    Hits: {hb[guessIndex].hit}
                                </span>
                                <span className="flex items-center">
                                    <div className="w-3 h-3 rounded-full bg-retro-yellow mr-1"></div>
                                    Blows: {hb[guessIndex].blow}
                                </span>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        )
    }

    return (
        <div className="retro-container flex flex-col items-center justify-center min-h-screen py-8">
            <motion.div
                className="retro-badge retro-badge-primary mb-4 text-lg"
                initial={{ scale: 0, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ delay: 0.2, duration: 0.3 }}
            >
                <Clock className="inline-block mr-2 h-4 w-4" /> Round {round} of {maxAttempts}
            </motion.div>

            <motion.div
                className="retro-card max-w-4xl w-full mb-6"
                initial={{ scale: 0.9, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ delay: 0.1, duration: 0.3 }}
            >
                {/* Game status */}
                <div className="flex justify-between items-center mb-4">
                    <button
                        onClick={onBack}
                        className="retro-button retro-button-outline flex items-center gap-1 py-1 px-2"
                    >
                        <ArrowLeft size={16} />
                        <span className="text-sm">Menu</span>
                    </button>

                    <div
                        className={`retro-badge ${isPlayerTurn ? 'retro-badge-success' : 'retro-badge-secondary'}`}
                    >
                        {isPlayerTurn ? 'Your Turn' : "Opponent's Turn"}
                    </div>
                </div>

                {/* Tabbed interface */}
                <div className="mb-6">
                    <div className="retro-tabs flex justify-center border-b-4 border-gray-200 dark:border-gray-700">
                        <button
                            onClick={() => setActiveTab('combined')}
                            className={`retro-tab px-4 py-2 font-bold ${
                                activeTab === 'combined'
                                    ? 'border-b-4 border-retro-red text-retro-red -mb-1'
                                    : 'text-gray-500'
                            }`}
                        >
                            <Users className="h-4 w-4 inline mr-2" />
                            Combined
                        </button>
                        <button
                            onClick={() => setActiveTab('opponent')}
                            className={`retro-tab px-4 py-2 font-bold ${
                                activeTab === 'opponent'
                                    ? 'border-b-4 border-retro-blue text-retro-blue -mb-1'
                                    : 'text-gray-500'
                            }`}
                        >
                            <Users className="h-4 w-4 inline mr-2" />
                            Opponent
                        </button>
                        <button
                            onClick={() => setActiveTab('you')}
                            className={`retro-tab px-4 py-2 font-bold ${
                                activeTab === 'you'
                                    ? 'border-b-4 border-retro-green text-retro-green -mb-1'
                                    : 'text-gray-500'
                            }`}
                        >
                            <User className="h-4 w-4 inline mr-2" />
                            You
                        </button>
                    </div>

                    {/* Tab content */}
                    <div className="mt-6">
                        <AnimatePresence mode="wait">
                            <motion.div
                                key={activeTab}
                                initial={{ opacity: 0, y: 10 }}
                                animate={{ opacity: 1, y: 0 }}
                                exit={{ opacity: 0, y: -10 }}
                                transition={{ duration: 0.2 }}
                            >
                                {activeTab === 'combined' && renderCombinedView()}
                                {activeTab === 'opponent' && renderOpponentView()}
                                {activeTab === 'you' && renderPlayerView()}
                            </motion.div>
                        </AnimatePresence>
                    </div>
                </div>

                {/* Input field for guesses */}
                <div className="max-w-md mx-auto">
                    <form onSubmit={handleSubmitGuess} className="flex flex-col items-center">
                        <div className="w-full mb-2">
                            <div className="flex">
                                <input
                                    type="text"
                                    value={inputGuess}
                                    onChange={handleInputChange}
                                    placeholder="Enter your 4-letter guess"
                                    className={`input retro-input w-full text-center uppercase ${
                                        inputError
                                            ? 'border-retro-red'
                                            : inputGuess.length === 4
                                              ? 'border-retro-green'
                                              : ''
                                    }`}
                                    disabled={!isPlayerTurn || !isLastHBSubmitted}
                                    maxLength={4}
                                />
                                <button
                                    type="submit"
                                    className="retro-button retro-button-primary ml-2"
                                    disabled={
                                        !isPlayerTurn || !!inputError || inputGuess.length !== 4
                                    }
                                >
                                    <Send className="h-5 w-5" />
                                </button>
                            </div>

                            {inputError && (
                                <div className="text-retro-red text-sm mt-1 flex items-center">
                                    <AlertCircle className="h-3 w-3 mr-1" />
                                    {inputError}
                                </div>
                            )}

                            {!isPlayerTurn && (
                                <div className="text-gray-500 dark:text-gray-400 text-sm mt-1 text-center">
                                    Waiting for opponent's move...
                                </div>
                            )}
                        </div>
                    </form>
                </div>

                {/* hb legend */}
                <div className="mt-6 p-4 bg-gray-100 dark:bg-gray-800 rounded-lg">
                    <h3 className="text-center font-bold mb-2">How to Read HB</h3>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div className="flex items-center">
                            <div className="w-8 h-8 rounded-full bg-retro-green flex items-center justify-center text-white font-bold mr-3">
                                2
                            </div>
                            <span>
                                <strong>Hits:</strong> Letters in the correct position
                            </span>
                        </div>
                        <div className="flex items-center">
                            <div className="w-8 h-8 rounded-full bg-retro-yellow flex items-center justify-center text-black font-bold mr-3">
                                1
                            </div>
                            <span>
                                <strong>Blows:</strong> Correct letters in wrong position
                            </span>
                        </div>
                    </div>
                    <div className="mt-3 text-sm text-center text-gray-600 dark:text-gray-400">
                        Example: If the secret word is "WORD" and you guess "WORK", you would get 3
                        Hits and 0 Blows
                    </div>
                </div>
            </motion.div>
        </div>
    )
}
