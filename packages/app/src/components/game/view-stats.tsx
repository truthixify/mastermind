import { motion } from 'framer-motion'
import { Trophy, XCircle, Users, Percent, Loader2, ArrowLeft } from 'lucide-react'
import { useEffect, useState } from 'react'
import { useScaffoldReadContract } from '../../hooks/scaffold-stark/useScaffoldReadContract'
import { feltToString } from '../../utils/utils'
import { Button } from '../ui/button'
import { useToast } from '../../hooks/use-toast'

interface ViewStatsProps {
    playerAddress: string | undefined
    onBack: () => void
}

export default function ViewStats({ playerAddress, onBack }: ViewStatsProps) {
    const [gamesWon, setGamesWon] = useState<number | null>(0)
    const [gamesLost, setGamesLost] = useState<number | null>(0)
    const [gamesTied, setGamesTied] = useState<number | null>(0)
    const [totalGames, setTotalGames] = useState<number | null>(0)
    const [winPercentage, setWinPercentage] = useState<string>('0.0')
    const { toast } = useToast()

    const { data: getGamesWon, isLoading: isLoadingGamesWon } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_player_total_games_won',
        args: [playerAddress]
    })

    const { data: getGamesLost, isLoading: isLoadingGamesLost } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_player_total_games_lost',
        args: [playerAddress]
    })

    const { data: getGamesTied, isLoading: isLoadingGamesTied } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_player_total_games_tied',
        args: [playerAddress]
    })

    const { data: playerName } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_player_name',
        args: [playerAddress]
    })

    useEffect(() => {
        if (!playerAddress) {
            toast({
                title: 'No Player Address',
                description: 'Please connect your wallet to view stats.'
            })
            return
        }

        const gamesWon = getGamesWon ? Number(getGamesWon) : 0
        const gamesLost = getGamesLost ? Number(getGamesLost) : 0
        const gamesTied = getGamesTied ? Number(getGamesTied) : 0

        setGamesWon(gamesWon)
        setGamesLost(gamesLost)
        setGamesTied(gamesTied)

        // Calculate total games and win percentage
        const totalGames = gamesWon + gamesLost + gamesTied
        setTotalGames(totalGames)
        setWinPercentage(
            totalGames > 0 ? (((gamesWon + 0.5 * gamesTied) / totalGames) * 100).toFixed(1) : '0.0'
        )
    }, [playerAddress, getGamesWon, getGamesLost, getGamesTied])

    // Animation variants for the stats cards
    const cardVariants = {
        hidden: { opacity: 0, y: 20 },
        visible: {
            opacity: 1,
            y: 0,
            transition: {
                duration: 0.3,
                staggerChildren: 0.1
            }
        }
    }

    const statItemVariants = {
        hidden: { opacity: 0, x: -10 },
        visible: { opacity: 1, x: 0 }
    }

    if (isLoadingGamesWon || isLoadingGamesLost || isLoadingGamesTied) {
        return (
            <div className="retro-container flex items-center justify-center min-h-screen">
                <span className="animate">
                    <Loader2 className="h-8 w-8 text-retro-blue animate-spin mr-4" />
                </span>
                Loading player stats...
            </div>
        )
    }

    return (
        <div className="retro-container flex flex-col items-center justify-center min-h-screen py-8">
            <motion.div
                className="retro-card max-w-lg w-full"
                initial={{ scale: 0.9, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ duration: 0.3 }}
            >
                <h2 className="text-2xl font-bold text-center mb-6 text-retro-red">Player Stats</h2>

                <div className="mb-4 text-center">
                    <span className="retro-badge retro-badge-primary flex items-center justify-center mx-auto">
                        <Users className="mr-2 h-4 w-4" />
                        {feltToString(playerName) || 'Unknown Player'}
                    </span>
                </div>

                <motion.div
                    className="grid grid-cols-1 md:grid-cols-2 gap-4"
                    variants={cardVariants}
                    initial="hidden"
                    animate="visible"
                >
                    {/* Games Won */}
                    <motion.div
                        className="retro-game-board p-4 rounded-lg bg-white dark:bg-gray-800 border-2 border-gray-300 dark:border-gray-700"
                        variants={statItemVariants}
                    >
                        <div className="flex items-center justify-between">
                            <div className="flex items-center">
                                <Trophy className="h-6 w-6 text-retro-green mr-3" />
                                <span className="font-bold">Games Won</span>
                            </div>
                            <span className="text-lg font-mono">{gamesWon}</span>
                        </div>
                    </motion.div>

                    {/* Games Lost */}
                    <motion.div
                        className="retro-game-board p-4 rounded-lg bg-white dark:bg-gray-800 border-2 border-gray-300 dark:border-gray-700"
                        variants={statItemVariants}
                    >
                        <div className="flex items-center justify-between">
                            <div className="flex items-center">
                                <XCircle className="h-6 w-6 text-retro-red mr-3" />
                                <span className="font-bold">Games Lost</span>
                            </div>
                            <span className="text-lg font-mono">{gamesLost}</span>
                        </div>
                    </motion.div>

                    {/* Games Tied */}
                    <motion.div
                        className="retro-game-board p-4 rounded-lg bg-white dark:bg-gray-800 border-2 border-gray-300 dark:border-gray-700"
                        variants={statItemVariants}
                    >
                        <div className="flex items-center justify-between">
                            <div className="flex items-center">
                                <Users className="h-6 w-6 text-retro-yellow mr-3" />
                                <span className="font-bold">Games Tied</span>
                            </div>
                            <span className="text-lg font-mono">{gamesTied}</span>
                        </div>
                    </motion.div>

                    {/* Win Percentage */}
                    <motion.div
                        className="retro-game-board p-4 rounded-lg bg-white dark:bg-gray-800 border-2 border-gray-300 dark:border-gray-700"
                        variants={statItemVariants}
                    >
                        <div className="flex items-center justify-between">
                            <div className="flex items-center">
                                <Percent className="h-6 w-6 text-retro-blue mr-3" />
                                <span className="font-bold mr-4">Win Rate</span>
                            </div>
                            <span className="text-lg font-mono">{winPercentage}%</span>
                        </div>
                    </motion.div>
                </motion.div>

                {/* Total Games Played */}
                <div className="mt-6 p-4 bg-gray-100 dark:bg-gray-800 rounded-lg text-center">
                    <h3 className="font-bold mb-2">Total Games Played</h3>
                    <span className="text-2xl font-mono">{totalGames}</span>
                </div>
                <Button className="w-full" size="sm" onClick={onBack}>
                    <ArrowLeft className="mr-2 h-4 w-4" />
                    Back to Dashboard
                </Button>
            </motion.div>
        </div>
    )
}
