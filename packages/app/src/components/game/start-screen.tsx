import { useState } from "react";
import { motion } from "framer-motion";
import { HelpCircle } from "lucide-react";
import HelpModal from "./help-modal";
import GameDashboard from "./game-dashboard";

interface StartScreenProps {
  onStartSinglePlayer: () => void;
  onCreateMultiplayer: () => void;
  onJoinMultiplayer: (gameId: string) => void;
  onContinueGame: (gameId: string) => void;
  highScore: number;
  gamesPlayed: number;
  gamesWon: number;
}

export default function StartScreen({
  onStartSinglePlayer,
  onCreateMultiplayer,
  onJoinMultiplayer,
  onContinueGame,
  highScore,
  gamesPlayed,
  gamesWon,
}: StartScreenProps) {
  const [showHelp, setShowHelp] = useState(false);
  const [showWelcome, setShowWelcome] = useState(true);

  const winRate =
    gamesPlayed > 0 ? Math.round((gamesWon / gamesPlayed) * 100) : 0;

  if (!showWelcome) {
    return (
      <>
        <GameDashboard
          onCreateGame={onCreateMultiplayer}
          onJoinGame={onJoinMultiplayer}
          onContinueGame={onContinueGame}
        />

        <div className="fixed bottom-4 right-4 flex gap-2">
          <motion.button
            className="retro-button retro-button-outline flex items-center gap-2 py-2 px-3"
            onClick={() => setShowWelcome(true)}
            initial={{ scale: 0.9, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.6, duration: 0.3 }}
          >
            Back to Welcome
          </motion.button>

          <motion.button
            className="retro-button retro-button-outline flex items-center gap-2 py-2 px-3"
            onClick={() => setShowHelp(true)}
            initial={{ scale: 0.9, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.7, duration: 0.3 }}
          >
            <HelpCircle size={18} />
            Help
          </motion.button>
        </div>

        <HelpModal isOpen={showHelp} onClose={() => setShowHelp(false)} />
      </>
    );
  }

  return (
    <div className="retro-container flex flex-col items-center justify-center min-h-screen">
      {/* <motion.h1
        className="retro-title"
        initial={{ y: -50, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: 0.5 }}
      >
        Word Mastermind
      </motion.h1> */}

      <motion.div
        className="retro-card max-w-md w-full mb-8"
        initial={{ scale: 0.8, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ delay: 0.2, duration: 0.5 }}
      >
        <div className="text-center mb-6">
          <h2 className="text-2xl mb-4 text-retro-blue font-bold">
            Can you crack the code?
          </h2>
          <p className="mb-4">
            Guess the secret 4-letter word. All letters are unique!
          </p>
          <p className="text-sm mb-2">
            You have 6 attempts to guess correctly.
          </p>
          <p className="text-sm">
            Green = correct letter, correct spot
            <br />
            Yellow = correct letter, wrong spot
          </p>
        </div>

        <div className="flex flex-col gap-4">
          <button
            onClick={onStartSinglePlayer}
            className="retro-button retro-button-primary text-xl px-8 py-4 flex items-center justify-center"
          >
            Single Player
          </button>

          <button
            onClick={() => setShowWelcome(false)}
            className="retro-button retro-button-secondary flex items-center justify-center"
          >
            Multiplayer Games
          </button>
        </div>
      </motion.div>

      {/* Stats card */}
      {gamesPlayed > 0 && (
        <motion.div
          className="retro-card max-w-md w-full mb-8"
          initial={{ scale: 0.8, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          transition={{ delay: 0.4, duration: 0.5 }}
        >
          <h2 className="text-xl mb-4 text-center text-retro-purple font-bold">
            Your Stats
          </h2>
          <div className="grid grid-cols-3 gap-4 text-center">
            <div>
              <p className="text-2xl text-retro-red font-bold">{gamesPlayed}</p>
              <p className="text-sm">Games Played</p>
            </div>
            <div>
              <p className="text-2xl text-retro-green font-bold">{winRate}%</p>
              <p className="text-sm">Win Rate</p>
            </div>
            <div>
              <p className="text-2xl text-retro-blue font-bold">
                {highScore > 0 ? highScore : "-"}
              </p>
              <p className="text-sm">Best Score</p>
            </div>
          </div>
        </motion.div>
      )}

      {/* Help button */}
      <motion.button
        className="retro-button retro-button-outline flex items-center gap-2"
        onClick={() => setShowHelp(true)}
        initial={{ y: 20, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ delay: 0.6, duration: 0.5 }}
      >
        <HelpCircle size={18} />
        How to Play
      </motion.button>

      {/* Help modal */}
      <HelpModal isOpen={showHelp} onClose={() => setShowHelp(false)} />
    </div>
  );
}
