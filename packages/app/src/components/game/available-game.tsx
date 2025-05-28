import { Users } from 'lucide-react'
import { useScaffoldReadContract } from '../../hooks/scaffold-stark/useScaffoldReadContract'
import { useScaffoldWriteContract } from '../../hooks/scaffold-stark/useScaffoldWriteContract'
import { useGameStore } from '../../stores/gameStore'
import { feltToString } from '../../utils/utils'

type AvailableGameProps = {
    id: number
    onJoinAvalaibleGame: () => void
}

const AvailableGame = ({ id, onJoinAvalaibleGame }: AvailableGameProps) => {
    const { setGameId } = useGameStore()
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

    const { data: opponentAddress } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_opponent_address',
        args: [id]
    })

    const { data: creatorName } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_player_name',
        args: [creatorAddress]
    })

    const handleJoinGame = async () => {
        setGameId(id)

        const res = await joinGame()

        if (res) onJoinAvalaibleGame()
    }

    return (
        <div className="retro-dashboard-card">
            <h3 className="font-bold text-lg mb-2">Game #{id}</h3>
            <p className="mb-2">Created by {feltToString(creatorName)}</p>
            <button
                onClick={handleJoinGame}
                className="retro-button retro-button-secondary w-full flex items-center justify-center"
            >
                Join Game
                <Users className="ml-2 h-4 w-4 inline" />
            </button>
        </div>
    )
}

export default AvailableGame
