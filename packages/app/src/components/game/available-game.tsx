import { Loader2, Users } from 'lucide-react'
import { useScaffoldReadContract } from '../../hooks/scaffold-stark/useScaffoldReadContract'
import { useScaffoldWriteContract } from '../../hooks/scaffold-stark/useScaffoldWriteContract'
import { useGameStore } from '../../stores/gameStore'
import { feltToString } from '../../utils/utils'
import { Button } from '../ui/button'
import { useToast } from '../../hooks/use-toast'
import { useState } from 'react'

type AvailableGameProps = {
    id: number
    onJoinAvalaibleGame: () => void
}

const AvailableGame = ({ id, onJoinAvalaibleGame }: AvailableGameProps) => {
    const { setGameId } = useGameStore()
    const [isJoiningGame, setIsJoiningGame] = useState(false)
    const { toast } = useToast()

    const { sendAsync: joinGame } = useScaffoldWriteContract({
        contractName: 'Mastermind',
        functionName: 'join_game',
        args: [id]
    })

    const { data: creatorAddress } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_creator_address',
        args: [id]
    })

    const { data: creatorName } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_player_name',
        args: [creatorAddress]
    })

    const handleJoinGame = async () => {
        setIsJoiningGame(true)

        try {
            setGameId(id)

            const res = await joinGame()

            if (res) {
                onJoinAvalaibleGame()
                toast({
                    title: 'Joined Game',
                    description: `You successfully joined game #${id}`
                })
            } else {
                toast({
                    title: 'Join Failed',
                    description: 'Unable to join the selected game. Please try again.',
                    variant: 'destructive'
                })
            }
        } catch (error: any) {
            toast({
                title: 'Join Game Error',
                description: error?.message || 'An unexpected error occurred.',
                variant: 'destructive'
            })
        } finally {
            setIsJoiningGame(false)
        }
    }

    return (
        <div className="retro-dashboard-card">
            <h3 className="font-bold text-lg mb-2">Game #{id}</h3>
            <p className="mb-2">Created by {feltToString(creatorName)}</p>
            <Button
                onClick={handleJoinGame}
                className="retro-button retro-button-secondary w-full flex items-center justify-center"
                variant={'secondary'}
                disabled={isJoiningGame}
            >
                {isJoiningGame && <Loader2 className="mr-2 h-5 w-5 animate-spin" />}
                {isJoiningGame ? 'Joining...' : 'Join Game'}
                {!isJoiningGame && <Users className="ml-2 h-4 w-4 inline" />}
            </Button>
        </div>
    )
}

export default AvailableGame
