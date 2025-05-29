import { ArrowRight, Loader2 } from 'lucide-react'
import { useScaffoldReadContract } from '../../hooks/scaffold-stark/useScaffoldReadContract'
import { feltToString } from '../../utils/utils'
import { useEffect, useState } from 'react'
import { useAccount } from '../../hooks/useAccount'
import { addAddressPadding } from 'starknet'
import { feltToHex } from '../../utils/scaffold-stark/common'

type ActiveGameProps = {
    id: number
    onContinueGame: (gameId: number) => void
}

const ActiveGame = ({ id, onContinueGame }: ActiveGameProps) => {
    const [isPlayerTurn, setIsPlayerTurn] = useState<boolean | null>(null)
    const { address } = useAccount()

    const { data: opponentAddress } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_opponent_address',
        args: [id]
    })

    const { data: opponentName } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_player_name',
        args: [opponentAddress]
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

    const { data: getGameCurrentRound } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_game_current_round',
        args: [id]
    })

    useEffect(() => {
        if (address === addAddressPadding(feltToHex(creatorAddress || 0n))) {
            setIsPlayerTurn(Number(getGameCurrentRound) % 2 === 1)
        } else if (address === addAddressPadding(feltToHex(opponentAddress || 0n))) {
            setIsPlayerTurn(Number(getGameCurrentRound) % 2 === 0)
        }
    }, [getGameCurrentRound, creatorAddress, opponentAddress])

    return (
        <div
            key={id}
            className={`retro-dashboard-card ${isPlayerTurn ? 'retro-dashboard-card-active' : ''}`}
        >
            <div className="flex justify-between items-center mb-2">
                <h3 className="font-bold text-lg">Game #{id}</h3>
                <span
                    className={`retro-badge ${isPlayerTurn ? 'retro-badge-success' : 'retro-badge-secondary'}`}
                >
                    {isPlayerTurn === null && '????'}
                    {isPlayerTurn === true && 'Your Turn'}
                    {isPlayerTurn === false && 'Waiting'}
                </span>
            </div>
            {creatorName && opponentName && getGameCurrentRound ? (
                <p className="flex justify-between mb-4">
                    <span>
                        {feltToString(creatorName)} vs. {feltToString(opponentName)}
                    </span>
                    <span>Round {getGameCurrentRound}</span>
                </p>
            ) : (
                <p className="flex items-center mb-4">
                    <Loader2 className="mr-2 h-5 w-5 animate-spin" />
                    Loading Game Details...
                </p>
            )}
            <button
                onClick={() => onContinueGame(id)}
                className={`retro-button ${isPlayerTurn ? 'retro-button-primary' : 'retro-button-outline'} w-full flex items-center justify-center`}
            >
                Continue Game
                <ArrowRight className="ml-2 h-4 w-4 inline" />
            </button>
        </div>
    )
}

export default ActiveGame
