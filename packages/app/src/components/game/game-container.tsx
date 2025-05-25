import { useState, useEffect } from "react";
import GameBoard from "./game-board";
import GameDashboard from "./game-dashboard";
import GameOverScreen from "./game-over-screen";
import CreateGameScreen from "./create-game-screen";
import JoinGameScreen from "./join-game-screen";
import CommitSolutionHash from "./commit-solution-hash-screen";
import { useToast } from "../../hooks/use-toast";
import { Toaster } from "../ui/toaster";
import { useMobile } from "../../hooks/use-mobile";
import { useScaffoldWriteContract } from "../../hooks/scaffold-stark/useScaffoldWriteContract";
import { useScaffoldReadContract } from "../../hooks/scaffold-stark/useScaffoldReadContract";
import { useGameStore } from "../../stores/gameStore";
import { useBlockNumber } from "@starknet-react/core";
import { useScaffoldEventHistory } from "../../hooks/scaffold-stark/useScaffoldEventHistory";
import { addAddressPadding, CairoCustomEnum } from "starknet";
import { useAccount } from "../../hooks/useAccount";
import { feltToHex } from "../../utils/scaffold-stark/common";

export type GameState =
  | "dashboard"
  | "create"
  | "join"
  | "commit"
  | "waiting"
  | "playing"
  | "won"
  | "lost"
  | "draw";

export default function GameContainer() {
  const isMobile = useMobile();
  const [gameState, setGameState] = useState<GameState>("dashboard");
  const { gameId, setGameId } = useGameStore();
  const { toast } = useToast();
  const [gameStage, setGameStage] = useState<CairoCustomEnum>();
  const [isPlayerTurn, setIsPlayerTurn] = useState<boolean>(true);
  const [creatorGuesses, setCreatorGuesses] = useState<string[]>(
    Array.from({ length: 5 }),
  );
  const [oppoentGuesses, setOpponentGuesses] = useState<string[]>(
    Array.from({ length: 5 }),
  );
  const [creatorHB, setCreatorHB] = useState<
    Array<{ hit: number; blow: number; submitted: boolean }>
  >(Array.from({ length: 5 }, () => ({ hit: 0, blow: 0, submitted: false })));
  const [opponentHB, setOpponentHB] = useState<
    Array<{ hit: number; blow: number; submitted: boolean }>
  >(Array.from({ length: 5 }, () => ({ hit: 0, blow: 0, submitted: false })));
  const [vk, setVk] = useState<Uint8Array | null>(null);

  const { sendAsync: createGame } = useScaffoldWriteContract({
    contractName: "Mastermind",
    functionName: "init_game",
  });

  const { sendAsync: joinGame } = useScaffoldWriteContract({
    contractName: "Mastermind",
    functionName: "join_game",
    args: [gameId],
  });

  const { data: getGameCurrentStage } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_current_stage",
    args: [gameId],
  });

  const { data: getGameCurrentRound } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_current_round",
    args: [gameId],
  });

  const { data: creatorAddress } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_creator_address",
    args: [gameId],
  });

  const { data: opponentAddress } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_opponent_address",
    args: [gameId],
  });

  const { data: creatorSubmittedGuesses } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_submitted_guesses",
    args: [gameId, creatorAddress],
  });

  const { data: opponentSubmittedGuesses } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_submitted_guesses",
    args: [gameId, opponentAddress],
  });

  const { data: creatorSubmittedHB } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_submitted_hit_and_blow",
    args: [gameId, creatorAddress],
  });

  const { data: opponentSubmittedHB } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_game_submitted_hit_and_blow",
    args: [gameId, opponentAddress],
  });

  const { address } = useAccount();

  const [playerRole, setPlayerRole] = useState<"creator" | "opponent" | null>(
    null,
  );

  const { data: blockNumber } = useBlockNumber();

  const { data: createEvent } = useScaffoldEventHistory({
    contractName: "Mastermind",
    eventName: "mastermind::Mastermind::InitializeGame",
    fromBlock: blockNumber
      ? blockNumber > 50n
        ? BigInt(blockNumber - 50)
        : 0n
      : 0n,
    watch: true,
  });

  // Create a new multiplayer game
  const createNewGame = async () => {
    const res = await createGame();

    if (res) {
      const gameId = createEvent[0].parsedArgs.game_id;
      setGameId(gameId);
      setGameState("commit");
      setGameStage(getGameCurrentStage);
    }
  };

  // Join an existing multiplayer game
  const joinExistingGame = async (gameId: number) => {
    setGameId(gameId);

    const res = await joinGame();

    if (res) {
      setGameState("commit");
      setGameStage(getGameCurrentStage);
    }
  };

  // Continue an existing game
  const continueGame = (gameId: number) => {
    toast({
      title: "Game Loaded",
      description: `Continuing game #${gameId}`,
    });

    setGameId(gameId);

    setGameState("playing");
  };

  const commit = () => {
    if (playerRole === "creator") {
      setGameState("waiting");
    } else {
      setGameState("playing");
    }
  };

  // Start the multiplayer game when both players are ready
  const startMultiplayerGame = () => {
    if (gameStage?.activeVariant() === "Playing") {
      setGameState("playing");
    }
  };

  const onJoinAvalaibleGame = () => {
    setGameState("commit");
  };

  // Play sound effects
  const playSound = (type: "guess" | "win" | "lose") => {
    const sounds = {
      guess: new Audio("/sounds/guess.mp3"),
      win: new Audio("/sounds/win.mp3"),
      lose: new Audio("/sounds/lose.mp3"),
    };

    try {
      sounds[type].volume = 0.5;
      sounds[type].play();
    } catch (error) {
      console.error("Error playing sound:", error);
    }
  };

  useEffect(() => {
    setGameStage(getGameCurrentStage);
  }, [getGameCurrentStage, commit]);

  useEffect(() => {
    if (playerRole === "creator") {
      setIsPlayerTurn(Number(getGameCurrentRound) % 2 === 1);
    } else if (playerRole === "opponent") {
      setIsPlayerTurn(Number(getGameCurrentRound) % 2 === 0);
    }
  }, [getGameCurrentRound, playerRole]);

  useEffect(() => {
    if (address && (creatorAddress || opponentAddress)) {
      if (address === addAddressPadding(feltToHex(creatorAddress || 0n))) {
        setPlayerRole("creator");
      } else if (
        address === addAddressPadding(feltToHex(opponentAddress || 0n))
      ) {
        setPlayerRole("opponent");
      }
    }
  }, [address, creatorAddress, opponentAddress]);

  useEffect(() => {
    if (creatorSubmittedGuesses && creatorSubmittedGuesses.length > 0) {
      let arr: string[] = Array.from({ length: 5 }, () => "");

      for (let i = 0; i < creatorSubmittedGuesses.length; i++) {
        arr[i] =
          String.fromCharCode(Number(creatorSubmittedGuesses[i].g1)) +
          String.fromCharCode(Number(creatorSubmittedGuesses[i].g2)) +
          String.fromCharCode(Number(creatorSubmittedGuesses[i].g3)) +
          String.fromCharCode(Number(creatorSubmittedGuesses[i].g4));
      }

      setCreatorGuesses(arr);
    }
    if (opponentSubmittedGuesses && opponentSubmittedGuesses.length > 0) {
      let arr: string[] = Array.from({ length: 5 }, () => "");

      for (let i = 0; i < creatorSubmittedGuesses.length; i++) {
        arr[i] =
          String.fromCharCode(Number(opponentSubmittedGuesses[i].g1)) +
          String.fromCharCode(Number(opponentSubmittedGuesses[i].g2)) +
          String.fromCharCode(Number(opponentSubmittedGuesses[i].g3)) +
          String.fromCharCode(Number(opponentSubmittedGuesses[i].g4));
      }

      setOpponentGuesses(arr);
    }
  }, [
    gameId,
    creatorAddress,
    opponentAddress,
    creatorSubmittedGuesses,
    opponentSubmittedGuesses,
  ]);

  useEffect(() => {
    if (creatorSubmittedHB && creatorSubmittedHB.length > 0) {
      let arr: { hit: number; blow: number; submitted: boolean }[] = Array.from(
        { length: 5 },
        () => ({ hit: 0, blow: 0, submitted: false }),
      );

      for (let i = 0; i < creatorSubmittedHB.length; i++) {
        arr[i].hit = creatorSubmittedHB[i].hit;
        arr[i].blow = creatorSubmittedHB[i].blow;
        arr[i].submitted = creatorSubmittedHB[i].submitted;
      }

      setCreatorHB(arr);
    }
    if (opponentSubmittedHB && opponentSubmittedHB.length > 0) {
      let arr: { hit: number; blow: number; submitted: boolean }[] = Array.from(
        { length: 5 },
        () => ({ hit: 0, blow: 0, submitted: false }),
      );

      for (let i = 0; i < opponentSubmittedHB.length; i++) {
        arr[i].hit = opponentSubmittedHB[i].hit;
        arr[i].blow = opponentSubmittedHB[i].blow;
        arr[i].submitted = creatorSubmittedHB[i].submitted;
      }

      setOpponentHB(arr);
    }
  }, [
    gameId,
    creatorAddress,
    opponentAddress,
    creatorSubmittedGuesses,
    opponentSubmittedGuesses,
  ]);

  // Render appropriate screen based on game state
  if (gameState === "dashboard") {
    return (
      <>
        <GameDashboard
          onCreateGame={createNewGame}
          onJoinGame={() => setGameState("join")}
          onContinueGame={continueGame}
          onJoinAvalaibleGame={onJoinAvalaibleGame}
          isPlayerTurn={isPlayerTurn}
        />
        <Toaster />
      </>
    );
  }

  if (gameState === "join") {
    return (
      <>
        <JoinGameScreen
          onJoinGame={joinExistingGame}
          onBack={() => setGameState("dashboard")}
        />
        <Toaster />
      </>
    );
  }

  if (gameState === "commit") {
    return (
      <>
        <CommitSolutionHash
          onCommit={commit}
          isMobile={isMobile}
          onBack={() => setGameState("dashboard")}
        />
        <Toaster />
      </>
    );
  }

  if (gameState === "waiting") {
    return (
      <>
        <CreateGameScreen
          onGameStart={startMultiplayerGame}
          onBack={() => setGameState("dashboard")}
        />
        <Toaster />
      </>
    );
  }

  if (gameState === "won" || gameState === "lost" || gameState === "draw") {
    return (
      <>
        <GameOverScreen
          gameState={gameState}
          attempts={
            playerRole === "creator"
              ? creatorSubmittedGuesses.length
              : opponentSubmittedGuesses.length
          }
          onPlayAgain={() => setGameState("dashboard")}
        />
        <Toaster />
      </>
    );
  }

  return (
    <>
      <GameBoard
        guesses={playerRole === "creator" ? creatorGuesses : oppoentGuesses}
        opponentGuesses={
          playerRole === "creator" ? oppoentGuesses : creatorGuesses
        }
        hb={playerRole === "creator" ? opponentHB : creatorHB}
        opponentHb={playerRole === "creator" ? creatorHB : opponentHB}
        isPlayerTurn={isPlayerTurn}
        round={getGameCurrentRound}
        playerRole={playerRole}
        onBack={() => setGameState("dashboard")}
        playerAddress={
          playerRole === "creator" ? creatorAddress : opponentAddress
        }
      />
      <Toaster />
    </>
  );
}
