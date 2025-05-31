import { motion, AnimatePresence } from 'framer-motion'
import { X, Users } from 'lucide-react'

interface HelpModalProps {
    isOpen: boolean
    onClose: () => void
}

export default function HelpModal({ isOpen, onClose }: HelpModalProps) {
    if (!isOpen) return null

    return (
        <AnimatePresence>
            {isOpen && (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black bg-opacity-50">
                    <motion.div
                        className="retro-card max-w-lg w-full max-h-[90vh] overflow-y-auto"
                        initial={{ scale: 0.9, opacity: 0 }}
                        animate={{ scale: 1, opacity: 1 }}
                        exit={{ scale: 0.9, opacity: 0 }}
                        transition={{ duration: 0.3 }}
                    >
                        <div className="flex justify-between items-center mb-4">
                            <h2 className="text-2xl font-bold">How to Play</h2>
                            <button
                                onClick={onClose}
                                className="retro-button retro-button-outline p-2"
                            >
                                <X className="h-4 w-4" />
                            </button>
                        </div>

                        <div className="space-y-4">
                            <p>
                                Word Mastermind is a multiplayer word-guessing game where you try to
                                guess your opponent's secret 4-letter word.
                            </p>

                            <div>
                                <h3 className="text-lg text-retro-blue font-bold mb-2">Rules:</h3>
                                <ul className="list-disc pl-5 space-y-1">
                                    <li>The secret word is always 4 letters long</li>
                                    <li>All letters in the word are unique (no repeats)</li>
                                    <li>You have 5 attempts to guess the word</li>
                                    <li>After each guess, you'll get feedback:</li>
                                </ul>
                            </div>

                            <div className="flex flex-col items-center space-y-2">
                                <div className="retro-legend">
                                    <div className="retro-legend-item">
                                        <div className="retro-legend-indicator bg-retro-green"></div>
                                        <span>Correct letter in correct position</span>
                                    </div>
                                </div>
                                <div className="retro-legend">
                                    <div className="retro-legend-item">
                                        <div className="retro-legend-indicator bg-retro-yellow"></div>
                                        <span>Correct letter in wrong position</span>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <h3 className="text-lg text-retro-blue font-bold mb-2">
                                    Game Flow:
                                </h3>
                                <div className="space-y-2">
                                    <div className="flex items-start">
                                        <Users className="h-5 w-5 mr-2 mt-0.5 flex-shrink-0 text-retro-blue" />
                                        <div>
                                            <p className="font-bold">Multiplayer</p>
                                            <p className="text-sm">
                                                Each player creates a secret word and tries to guess
                                                their opponent's word. Players take turns making
                                                guesses. The first player to guess correctly wins!
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <h3 className="text-lg text-retro-blue font-bold mb-2">
                                    Proving Guesses:
                                </h3>
                                <p className="text-sm">
                                    You can click the "Prove" button next to your opponent's guesses
                                    to reveal the feedback they received. This helps verify that the
                                    game is fair and that your opponent is receiving the correct
                                    feedback.
                                </p>
                            </div>

                            <div>
                                <h3 className="text-lg text-retro-blue font-bold mb-2">Tips:</h3>
                                <ul className="list-disc pl-5 space-y-1">
                                    <li>Use the feedback to narrow down possible letters</li>
                                    <li>The keyboard shows which letters you've tried</li>
                                    <li>Try to use different letters in each guess</li>
                                    <li>Remember that all letters in the secret word are unique</li>
                                </ul>
                            </div>

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
                                            <strong>Blows:</strong> Correct letters in wrong
                                            position
                                        </span>
                                    </div>
                                </div>
                                <div className="mt-3 text-sm text-center text-gray-600 dark:text-gray-400">
                                    Example: If the secret word is "WORD" and you guess "WORK", you
                                    would get 3 Hits and 0 Blows.
                                </div>
                                <div className="mt-2 text-sm text-center font-semibold text-retro-blue">
                                    To win, you need <strong>4 Hits</strong> and{' '}
                                    <strong>0 Blows</strong> — that means you guessed the word
                                    exactly!
                                </div>
                            </div>
                        </div>

                        <div className="mt-6 text-center">
                            <button onClick={onClose} className="retro-button retro-button-primary">
                                Got it!
                            </button>
                        </div>
                    </motion.div>
                </div>
            )}
        </AnimatePresence>
    )
}
