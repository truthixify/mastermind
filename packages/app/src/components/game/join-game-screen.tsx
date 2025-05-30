import type React from 'react'
import { useState } from 'react'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '../ui/card'
import { Button } from '../ui/button'
import { Input } from '../ui/input'
import { ArrowLeft, Loader2 } from 'lucide-react'
import { useToast } from '../../hooks/use-toast'

interface JoinGameScreenProps {
    isJoiningGame: boolean
    onJoinGame: (internalGameId: number) => void
    onBack: () => void
}

export default function JoinGameScreen({ isJoiningGame, onJoinGame, onBack }: JoinGameScreenProps) {
    const [internalGameId, setinternalGameId] = useState<string | null>(null)
    const { toast } = useToast()

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault()

        const numInternalGameId = Number(internalGameId)

        if (!internalGameId || isNaN(numInternalGameId) || numInternalGameId <= 0) {
            return toast({
                title: 'Invalid Game ID',
                description: 'Please enter a valid game ID.',
                variant: 'destructive'
            })
        }

        onJoinGame(numInternalGameId)
    }

    return (
        <div className="flex flex-col items-center justify-center min-h-screen p-4">
            <Card className="w-full max-w-md retro-dashboard-card">
                <CardHeader>
                    <CardTitle className="text-2xl text-center">Join Game</CardTitle>
                    <CardDescription className="text-center">
                        Enter the game ID shared by your opponent
                    </CardDescription>
                </CardHeader>
                <CardContent>
                    <form onSubmit={handleSubmit} className="space-y-4">
                        <div className="space-y-2">
                            <div className="text-sm font-medium">Game ID</div>
                            <Input
                                placeholder="Enter game ID"
                                value={internalGameId ?? ''}
                                onChange={e => setinternalGameId(e.target.value)}
                                className="font-mono"
                            />
                        </div>
                        <Button
                            type="submit"
                            className="w-full"
                            size={'lg'}
                            disabled={isJoiningGame}
                        >
                            {isJoiningGame && <Loader2 className="mr-2 h-5 w-5 animate-spin" />}
                            {isJoiningGame ? 'Joining...' : 'Join Game'}
                        </Button>
                    </form>
                </CardContent>
                <CardFooter className="flex justify-center">
                    <Button variant="ghost" size="sm" onClick={onBack}>
                        <ArrowLeft className="mr-2 h-4 w-4" />
                        Back to Dashboard
                    </Button>
                </CardFooter>
            </Card>
        </div>
    )
}
