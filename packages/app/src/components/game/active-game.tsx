import { ArrowRight } from "lucide-react";
import { useScaffoldReadContract } from "../../hooks/scaffold-stark/useScaffoldReadContract";
import { feltToString } from "../../utils/utils";

type ActiveGameProps = {
  id: number;
  onContinueGame: (gameId: number) => void;
  isPlayerTurn: boolean;
};

const ActiveGame = ({ id, onContinueGame, isPlayerTurn }: ActiveGameProps) => {
  const { data: opponentAddress } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_opponent_address",
    args: [id],
  });

  const { data: opponentName } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_player_name",
    args: [opponentAddress],
  });

  const { data: creatorAddress } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_creator_address",
    args: [id],
  });

  const { data: creatorName } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_player_name",
    args: [creatorAddress],
  });

  const { data: getGameCurrentRound } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_current_round",
    args: [id],
  });

  return (
    <div
      key={id}
      className={`retro-dashboard-card ${isPlayerTurn ? "retro-dashboard-card-active" : ""}`}
    >
      <div className="flex justify-between items-center mb-2">
        <h3 className="font-bold text-lg">Game #{id}</h3>
        <span
          className={`retro-badge ${isPlayerTurn ? "retro-badge-success" : "retro-badge-secondary"}`}
        >
          {isPlayerTurn ? "Your Turn" : "Waiting"}
        </span>
      </div>
      <p className="mb-2">
        {feltToString(creatorName)} vs. {feltToString(opponentName)} • Round{" "}
        {getGameCurrentRound}
      </p>
      <button
        onClick={() => onContinueGame(id)}
        className={`retro-button ${isPlayerTurn ? "retro-button-primary" : "retro-button-outline"} w-full flex items-center justify-center`}
      >
        Continue Game
        <ArrowRight className="ml-2 h-4 w-4 inline" />
      </button>
    </div>
  );
};

export default ActiveGame;
