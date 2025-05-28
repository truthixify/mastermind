import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '../ui/card'
import { Button } from '../ui/button'
import { Input } from '../ui/input'
import { Copy, Loader2, ArrowLeft } from 'lucide-react'
import { useState, useEffect } from 'react'
import { useToast } from '../../hooks/use-toast'
import { useGameStore } from '../../stores/gameStore'
import { useScaffoldReadContract } from '../../hooks/scaffold-stark/useScaffoldReadContract'
import { CairoCustomEnum } from 'starknet'
import { useAccount } from '../../hooks/useAccount'

interface CreateGameScreenProps {
    onGameStart: () => void
    onBack: () => void
}

export default function CreateGameScreen({ onGameStart, onBack }: CreateGameScreenProps) {
    const { toast } = useToast()
    const [copied, setCopied] = useState(false)
    const [gameStage, setGameStage] = useState<CairoCustomEnum>()

    const { gameId } = useGameStore()
    const { address } = useAccount()

    const { data: getGameCurrentStage } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_current_stage',
        args: [gameId]
    })

    const { data: getSolutionHash } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_solution_hash',
        args: [gameId, address]
    })

    // Auto-redirect when opponent joins
    useEffect(() => {
        onGameStart()
    }, [gameStage, onGameStart])

    useEffect(() => {
        setGameStage(getGameCurrentStage)
    }, [getGameCurrentStage])

    const copyToClipboard = () => {
        navigator.clipboard.writeText(String(gameId))
        setCopied(true)
        toast({
            title: 'Game ID copied!',
            description: 'Share this with your opponent to join the game.'
        })
        setTimeout(() => setCopied(false), 2000)
    }

    return (
        <div className="flex flex-col items-center justify-center min-h-screen p-4">
            <Card className="w-full max-w-md retro-card z-10 p-6">
                <CardHeader>
                    <CardTitle className="text-2xl text-center">Game Created</CardTitle>
                    <CardDescription className="text-center">
                        Share this game ID with your opponent
                    </CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                    <div className="space-y-2">
                        <div className="text-sm font-medium">Your secret word's commit hash:</div>
                        <div className="p-3 bg-slate-100 dark:bg-slate-600 rounded-md text-xs font-mono break-all">
                            {getSolutionHash}
                        </div>
                    </div>

                    <div className="space-y-2">
                        <div className="text-sm font-medium">Game ID:</div>
                        <div className="flex gap-2">
                            <Input value={gameId} readOnly className="font-mono" />
                            <Button size="icon" onClick={copyToClipboard} variant="outline">
                                <Copy className="h-4 w-4" />
                            </Button>
                        </div>
                    </div>

                    {gameStage?.activeVariant() === 'WaitingForOpponent' && (
                        <div className="flex flex-col items-center justify-center p-4">
                            <Loader2 className="h-8 w-8 animate-spin text-slate-500 dark:text-slate-400" />
                            <p className="mt-2 text-sm text-slate-600 dark:text-slate-400">
                                Waiting for opponent to join...
                            </p>
                        </div>
                    )}
                    {gameStage?.activeVariant() === 'OpponentCommitSolutionHash' && (
                        <div className="flex flex-col items-center justify-center p-4">
                            <Loader2 className="h-8 w-8 animate-spin text-slate-500 dark:text-slate-400" />
                            <p className="text-sm text-slate-600 dark:text-slate-400">
                                Opponent commiting solution hash...
                            </p>
                        </div>
                    )}
                </CardContent>
                <CardFooter className="flex justify-between">
                    <Button variant="ghost" size="sm" onClick={onBack}>
                        <ArrowLeft className="mr-2 h-4 w-4" />
                        Back to Dashboard
                    </Button>
                    <p className="text-xs text-slate-500 dark:text-slate-400">
                        The game will start automatically when your opponent joins.
                    </p>
                </CardFooter>
            </Card>
        </div>
    )
}
