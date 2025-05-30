// @ts-nocheck
import { useState, useEffect } from 'react'
import GameBoard from './game-board'
import GameDashboard from './game-dashboard'
import GameOverScreen from './game-over-screen'
import CreateGameScreen from './create-game-screen'
import JoinGameScreen from './join-game-screen'
import CommitSolutionHash from './commit-solution-hash-screen'
import { useToast } from '../../hooks/use-toast'
import { Toaster } from '../ui/toaster'
import { useScaffoldWriteContract } from '../../hooks/scaffold-stark/useScaffoldWriteContract'
import { useScaffoldReadContract } from '../../hooks/scaffold-stark/useScaffoldReadContract'
import { useGameStore } from '../../stores/gameStore'
import { useBlockNumber } from '@starknet-react/core'
import { useScaffoldEventHistory } from '../../hooks/scaffold-stark/useScaffoldEventHistory'
import { addAddressPadding, CairoCustomEnum } from 'starknet'
import { useAccount } from '../../hooks/useAccount'
import { feltToHex } from '../../utils/scaffold-stark/common'
import { useGameStorage } from '../../hooks/use-game-storage'
import ViewStats from './view-stats'
import PlayerRegistration from './user-registration'

export type GameState =
    | 'register'
    | 'dashboard'
    | 'create'
    | 'join'
    | 'commit'
    | 'waiting'
    | 'playing'
    | 'won'
    | 'lost'
    | 'draw'
    | 'reveal'
    | 'stats'

export type GameCreationStatus = 'idle' | 'creating' | 'waiting_event' | 'error'

export default function GameContainer() {
    const [gameState, setGameState] = useState<GameState>('dashboard')
    const [gameStage, setGameStage] = useState<CairoCustomEnum>()
    const [isPlayerTurn, setIsPlayerTurn] = useState<boolean>(true)
    const [creatorGuesses, setCreatorGuesses] = useState<string[]>(Array.from({ length: 5 }))
    const [opponentGuesses, setOpponentGuesses] = useState<string[]>(Array.from({ length: 5 }))
    const [creatorHB, setCreatorHB] = useState<
        Array<{ hit: number; blow: number; submitted: boolean }>
    >(Array.from({ length: 5 }, () => ({ hit: 0, blow: 0, submitted: false })))
    const [opponentHB, setOpponentHB] = useState<
        Array<{ hit: number; blow: number; submitted: boolean }>
    >(Array.from({ length: 5 }, () => ({ hit: 0, blow: 0, submitted: false })))
    const [gameResult, setGameResult] = useState<CairoCustomEnum>()
    const [revealedSolution, setRevealedSolution] = useState<string>()
    const [opponentRevealedSolution, setOpponentRevealedSolution] = useState<string>()
    const [isRevealed, setIsRevealed] = useState(false)
    const [awaitingGameCreateEvent, setAwaitingGameCreateEvent] = useState(false)
    const [isJoiningGame, setIsJoiningGame] = useState(false)
    const [playerRole, setPlayerRole] = useState<'creator' | 'opponent' | null>(null)
    const [gameCreationStatus, setGameCreationStatus] = useState<GameCreationStatus>('idle')
    const [isRegistering, setIsRegistering] = useState(false)

    const { gameId, setGameId } = useGameStore()
    const { toast } = useToast()
    const { getGameData } = useGameStorage('game-data')
    const { address } = useAccount()

    const { data: blockNumber } = useBlockNumber()

    const { sendAsync: createGame } = useScaffoldWriteContract({
        contractName: 'Mastermind',
        functionName: 'init_game'
    })

    const { sendAsync: joinGame } = useScaffoldWriteContract({
        contractName: 'Mastermind',
        functionName: 'join_game'
    })

    const { sendAsync: revealSolution } = useScaffoldWriteContract({
        contractName: 'Mastermind',
        functionName: 'reveal_solution'
    })

    const { sendAsync: registerPlayer } = useScaffoldWriteContract({
        contractName: 'Mastermind',
        functionName: 'register_player'
    })

    const { data: getGameCurrentStage } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_current_stage',
        args: [gameId]
    })

    const { data: getGameCurrentRound } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_current_round',
        args: [gameId]
    })

    const { data: creatorAddress } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_creator_address',
        args: [gameId]
    })

    const { data: opponentAddress } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_opponent_address',
        args: [gameId]
    })

    const { data: creatorSubmittedGuesses } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_submitted_guesses',
        args: [gameId, creatorAddress]
    })

    const { data: opponentSubmittedGuesses } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_submitted_guesses',
        args: [gameId, opponentAddress]
    })

    const { data: creatorSubmittedHB } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_submitted_hit_and_blow',
        args: [gameId, creatorAddress]
    })

    const { data: opponentSubmittedHB } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_submitted_hit_and_blow',
        args: [gameId, opponentAddress]
    })

    const { data: getGameResult } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_result',
        args: [gameId]
    })

    const { data: getPlayerName } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_player_name',
        args: [address]
    })

    const { data: createEvent } = useScaffoldEventHistory({
        contractName: 'Mastermind',
        eventName: 'mastermind::Mastermind::InitializeGame',
        fromBlock: blockNumber ? (blockNumber > 50n ? BigInt(blockNumber - 50) : 0n) : 0n,
        watch: true,
        filters: {
            account: address
        }
    })

    const { data: gameFinishEvent } = useScaffoldEventHistory({
        contractName: 'Mastermind',
        eventName: 'mastermind::Mastermind::GameFinish',
        fromBlock: blockNumber ? (blockNumber > 50n ? BigInt(blockNumber - 50) : 0n) : 0n,
        watch: true,
        filters: {
            game_id: gameId
        }
    })

    const { data: revealSolutionEvent } = useScaffoldEventHistory({
        contractName: 'Mastermind',
        eventName: 'mastermind::Mastermind::RevealSolution',
        fromBlock: blockNumber ? (blockNumber > 50n ? BigInt(blockNumber - 50) : 0n) : 0n,
        watch: true,
        filters: {
            game_id: gameId,
            account: creatorAddress
        }
    })

    const { data: opponentRevealSolutionEvent } = useScaffoldEventHistory({
        contractName: 'Mastermind',
        eventName: 'mastermind::Mastermind::RevealSolution',
        fromBlock: blockNumber ? (blockNumber > 50n ? BigInt(blockNumber - 50) : 0n) : 0n,
        watch: true,
        filters: {
            game_id: gameId,
            account: opponentAddress
        }
    })

    // Reset game state when gameId changes
    const resetGameState = () => {
        setCreatorGuesses(Array.from({ length: 5 }))
        setOpponentGuesses(Array.from({ length: 5 }))
        setCreatorHB(Array.from({ length: 5 }, () => ({ hit: 0, blow: 0, submitted: false })))
        setOpponentHB(Array.from({ length: 5 }, () => ({ hit: 0, blow: 0, submitted: false })))
        setRevealedSolution(undefined)
        setOpponentRevealedSolution(undefined)
        setGameResult(undefined)
        setPlayerRole(null)
        setIsPlayerTurn(false)
        setIsRevealed(false)
        setAwaitingGameCreateEvent(false)
        setGameStage(undefined)
    }

    // Register a new player
    const onRegister = async (username: string) => {
        setIsRegistering(true)
        try {
            await registerPlayer({
                args: [username]
            })

            toast({
                title: 'Registration successful!',
                description: `Welcome to Word Mastermind, ${username}!`
            })

            setGameState('dashboard')
        } catch (error: any) {
            toast({
                title: 'Registration failed',
                description:
                    error?.message ||
                    'There was an error registering your username. Please try again.',
                variant: 'destructive'
            })
        } finally {
            setIsRegistering(false)
        }
    }

    // Create a new multiplayer game
    const createNewGame = async () => {
        resetGameState()
        setGameCreationStatus('creating')

        try {
            const res = await createGame()

            if (!res) {
                setGameCreationStatus('error')
                toast({
                    title: 'Game Creation Failed',
                    description: 'Failed to create a new game. Please try again.',
                    variant: 'destructive'
                })

                return
            }

            // Wait for event to confirm game creation
            setGameCreationStatus('waiting_event')
        } catch (error: any) {
            setGameCreationStatus('error')
            toast({
                title: 'Game Creation Error',
                description: error || 'An unexpected error occurred.',
                variant: 'destructive'
            })
        }
    }

    // Join an existing multiplayer game
    const joinExistingGame = async (gameId: number) => {
        resetGameState()
        setIsJoiningGame(true)

        try {
            setGameId(gameId)

            const res = await joinGame({
                args: [gameId]
            })

            if (res) {
                toast({
                    title: 'Joining Game',
                    description: `Successfully joined game #${gameId}`
                })
                setGameState('commit')
            } else {
                throw new Error('Failed to join game')
            }
        } catch (error: any) {
            console.error('Join Game Error:', error)
            toast({
                title: 'Join Game Error',
                description: error?.message || String(error),
                variant: 'destructive'
            })
        } finally {
            setIsJoiningGame(false)
        }
    }

    // Continue an existing game
    const continueGame = (gameId: number) => {
        resetGameState()

        toast({
            title: 'Game Loaded',
            description: `Continuing game #${gameId}`
        })

        setGameId(gameId)

        setGameState('playing')
    }

    const onCcommit = () => {
        if (playerRole === 'creator') {
            setGameState('waiting')
        } else {
            setGameState('playing')
        }
    }

    // Start the multiplayer game when both players are ready
    const startMultiplayerGame = () => {
        resetGameState()

        if (gameStage?.activeVariant() === 'Playing') {
            setGameState('playing')
        }
    }

    const onJoinAvalaibleGame = () => {
        resetGameState()
        setGameState('commit')
    }

    const onRevealSolution = async () => {
        try {
            const solution = getGameData(Number(gameId))?.solution
            const salt = getGameData(Number(gameId))?.salt

            if (!solution || !solution.length) {
                toast({
                    title: 'Unable to Reveal',
                    description: "The solution couldn't be loaded. Please try again.",
                    variant: 'destructive'
                })
                return
            }

            if (!salt || salt === '0') {
                toast({
                    title: 'Unable to Reveal',
                    description: "The salt couldn't be loaded. Please try again.",
                    variant: 'destructive'
                })
                return
            }

            const res = await revealSolution({
                args: [gameId, solution, BigInt(salt)]
            })

            if (res) {
                toast({
                    title: 'Solution Revealed',
                    description: 'Your solution has been revealed successfully.'
                })
                setIsRevealed(true)
            } else {
                toast({
                    title: 'Reveal Failed',
                    description: 'Failed to reveal the solution. Please try again.',
                    variant: 'destructive'
                })
            }
        } catch (error: any) {
            toast({
                title: 'Reveal Error',
                description: error?.message || 'An error occurred while revealing the solution.',
                variant: 'destructive'
            })
        }
    }

    const onViewStats = () => {
        setGameState('stats')
    }

    // Play sound effects
    const playSound = (type: 'play' | 'finish') => {
        const sounds = {
            play: new Audio('/sounds/play.wav'),
            finish: new Audio('/sounds/finish.wav')
        }

        try {
            sounds[type].volume = 0.5
            sounds[type].play()
        } catch (error) {
            console.error('Error playing sound:', error)
        }
    }

    useEffect(() => {
        if (gameCreationStatus !== 'waiting_event' || !createEvent?.length) return

        const firstEvent = createEvent[0]
        const gameId = firstEvent?.parsedArgs?.game_id
        if (!gameId) return

        setGameId(gameId)
        setGameStage(getGameCurrentStage)
        setGameState('commit')
        setGameCreationStatus('idle')

        toast({
            title: 'Game Created',
            description: `Created new game with ID: #${gameId}`
        })
    }, [gameCreationStatus, createEvent])

    useEffect(() => {
        if (!getGameCurrentStage) return

        setGameStage(prev => (prev !== getGameCurrentStage ? getGameCurrentStage : prev))
    }, [getGameCurrentStage, gameStage])

    useEffect(() => {
        if (getGameCurrentRound === undefined) return

        const roundNum = Number(getGameCurrentRound)
        if (playerRole === 'creator') {
            setIsPlayerTurn(roundNum % 2 === 1)
        } else if (playerRole === 'opponent') {
            setIsPlayerTurn(roundNum % 2 === 0)
        }
    }, [getGameCurrentRound, playerRole])

    useEffect(() => {
        if (address && (creatorAddress || opponentAddress)) {
            if (address === addAddressPadding(feltToHex(creatorAddress || 0n))) {
                setPlayerRole('creator')
            } else if (address === addAddressPadding(feltToHex(opponentAddress || 0n))) {
                setPlayerRole('opponent')
            }
        }
    }, [address, creatorAddress, opponentAddress, playerRole])

    useEffect(() => {
        if (creatorSubmittedGuesses && creatorSubmittedGuesses.length > 0) {
            const arr: string[] = Array.from({ length: 5 }, () => '')

            for (let i = 0; i < creatorSubmittedGuesses.length; i++) {
                arr[i] =
                    String.fromCharCode(Number(creatorSubmittedGuesses[i].g1)) +
                    String.fromCharCode(Number(creatorSubmittedGuesses[i].g2)) +
                    String.fromCharCode(Number(creatorSubmittedGuesses[i].g3)) +
                    String.fromCharCode(Number(creatorSubmittedGuesses[i].g4))
            }

            setCreatorGuesses(arr)
        }
        if (opponentSubmittedGuesses && opponentSubmittedGuesses.length > 0) {
            const arr: string[] = Array.from({ length: 5 }, () => '')

            for (let i = 0; i < opponentSubmittedGuesses.length; i++) {
                arr[i] =
                    String.fromCharCode(Number(opponentSubmittedGuesses[i].g1)) +
                    String.fromCharCode(Number(opponentSubmittedGuesses[i].g2)) +
                    String.fromCharCode(Number(opponentSubmittedGuesses[i].g3)) +
                    String.fromCharCode(Number(opponentSubmittedGuesses[i].g4))
            }

            setOpponentGuesses(arr)
        }
    }, [gameId, creatorAddress, opponentAddress, creatorSubmittedGuesses, opponentSubmittedGuesses])

    useEffect(() => {
        if (creatorSubmittedHB && creatorSubmittedHB.length > 0) {
            const arr: { hit: number; blow: number; submitted: boolean }[] = Array.from(
                { length: 5 },
                () => ({ hit: 0, blow: 0, submitted: false })
            )

            for (let i = 0; i < creatorSubmittedHB.length; i++) {
                arr[i].hit = creatorSubmittedHB[i].hit
                arr[i].blow = creatorSubmittedHB[i].blow
                arr[i].submitted = creatorSubmittedHB[i].submitted
            }

            setCreatorHB(arr)
        }
        if (opponentSubmittedHB && opponentSubmittedHB.length > 0) {
            const arr: { hit: number; blow: number; submitted: boolean }[] = Array.from(
                { length: 5 },
                () => ({ hit: 0, blow: 0, submitted: false })
            )

            for (let i = 0; i < opponentSubmittedHB.length; i++) {
                arr[i].hit = opponentSubmittedHB[i].hit
                arr[i].blow = opponentSubmittedHB[i].blow
                arr[i].submitted = opponentSubmittedHB[i].submitted
            }

            setOpponentHB(arr)
        }
    }, [gameId, creatorAddress, opponentAddress, creatorSubmittedHB, opponentSubmittedHB])

    useEffect(() => {
        setGameResult(getGameResult)
    }, [gameFinishEvent])

    useEffect(() => {
        if (revealSolutionEvent && revealSolutionEvent.length > 0) {
            const revealedSolution = revealSolutionEvent[0].parsedArgs.solution

            setRevealedSolution(
                revealedSolution
                    .map((char: bigint) => String.fromCharCode(Number(char)).toUpperCase())
                    .join('')
            )
        }

        if (opponentRevealSolutionEvent && opponentRevealSolutionEvent.length > 0) {
            const opponentRevealedSolution = opponentRevealSolutionEvent[0].parsedArgs.solution

            setOpponentRevealedSolution(
                opponentRevealedSolution
                    .map((char: bigint) => String.fromCharCode(Number(char)).toUpperCase())
                    .join('')
            )
        }
    }, [revealSolutionEvent, opponentRevealSolutionEvent])

    useEffect(() => {
        if (typeof address === 'undefined') return // Wallet not connected yet

        if (getPlayerName === undefined) return

        if (!getPlayerName) {
            setGameState('register')
        } else {
            setGameState('dashboard')
        }
    }, [address, getPlayerName])

    // Render appropriate screen based on game state
    if (gameState === 'dashboard') {
        return (
            <>
                <GameDashboard
                    onCreateGame={createNewGame}
                    gameCreationStatus={gameCreationStatus}
                    onJoinGame={() => setGameState('join')}
                    onContinueGame={continueGame}
                    onJoinAvalaibleGame={onJoinAvalaibleGame}
                    onViewStats={onViewStats}
                />
                <Toaster />
            </>
        )
    }

    if (gameState === 'register') {
        return <PlayerRegistration onRegister={onRegister} isRegistering={isRegistering} />
    }

    if (gameState === 'join') {
        return (
            <>
                <JoinGameScreen
                    isJoiningGame={isJoiningGame}
                    onJoinGame={joinExistingGame}
                    onBack={() => setGameState('dashboard')}
                />
                <Toaster />
            </>
        )
    }

    if (gameState === 'commit') {
        return (
            <>
                <CommitSolutionHash onCommit={onCcommit} onBack={() => setGameState('dashboard')} />
                <Toaster />
            </>
        )
    }

    if (gameState === 'waiting') {
        return (
            <>
                <CreateGameScreen
                    onGameStart={startMultiplayerGame}
                    onBack={() => setGameState('dashboard')}
                />
                <Toaster />
            </>
        )
    }

    if (gameState === 'stats') {
        return <ViewStats playerAddress={address} onBack={() => setGameState('dashboard')} />
    }

    if (gameStage?.activeVariant() === 'Reveal' || gameState === 'reveal') {
        return (
            <>
                <GameOverScreen
                    gameResult={gameResult}
                    revealedSolution={
                        playerRole === 'creator' ? revealedSolution : opponentRevealedSolution
                    }
                    opponentRevealedSolution={
                        playerRole === 'creator' ? opponentRevealedSolution : revealedSolution
                    }
                    onRevealSolution={onRevealSolution}
                    isRevealed={isRevealed}
                    onPlayAgain={() => setGameState('dashboard')}
                    playSound={playSound}
                />
                <Toaster />
            </>
        )
    }

    return (
        <>
            <GameBoard
                guesses={playerRole === 'creator' ? creatorGuesses : opponentGuesses}
                opponentGuesses={playerRole === 'creator' ? opponentGuesses : creatorGuesses}
                hb={playerRole === 'creator' ? opponentHB : creatorHB}
                opponentHb={playerRole === 'creator' ? creatorHB : opponentHB}
                isPlayerTurn={isPlayerTurn}
                round={getGameCurrentRound ? Number(getGameCurrentRound) : undefined}
                playerRole={playerRole}
                onBack={() => setGameState('dashboard')}
                playerAddress={playerRole === 'creator' ? creatorAddress : opponentAddress}
                playSound={playSound}
            />
            <Toaster />
        </>
    )
}
