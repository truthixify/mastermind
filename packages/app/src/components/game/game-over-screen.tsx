import { motion } from "framer-motion";
import Confetti from "react-confetti";
import { useWindowSize } from "../../hooks/use-window-size";
import { useState, useEffect } from "react";
import { User, Users } from "lucide-react";

interface GameOverScreenProps {
  gameState: "won" | "lost" | "draw";
  attempts: number;
  onPlayAgain: () => void;
}

export default function GameOverScreen({
  gameState,
  attempts,
  onPlayAgain,
}: GameOverScreenProps) {
  const { width, height } = useWindowSize();
  const [showConfetti, setShowConfetti] = useState(
    gameState === "won" || gameState === "draw",
  );

  // Stop confetti after 5 seconds
  useEffect(() => {
    if (gameState === "won" || gameState === "draw") {
      const timer = setTimeout(() => {
        setShowConfetti(false);
      }, 5000);

      return () => clearTimeout(timer);
    }
  }, [gameState]);

  return (
    <div className="retro-container flex flex-col items-center justify-center min-h-screen">
      {showConfetti && (
        <Confetti width={width} height={height} recycle={false} />
      )}

      <motion.h1
        className={`retro-title text-4xl md:text-6xl mb-8 ${
          gameState === "won"
            ? "text-retro-green"
            : gameState === "draw"
              ? "text-retro-blue"
              : "text-retro-red"
        }`}
        initial={{ scale: 0.5, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ type: "spring", stiffness: 300, damping: 15 }}
      >
        {gameState === "won"
          ? "You Won!"
          : gameState === "draw"
            ? "It's a Draw!"
            : "Game Over!"}
      </motion.h1>

      <motion.div
        className="retro-card max-w-md w-full mb-8"
        initial={{ y: 50, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ delay: 0.3, duration: 0.5 }}
      >
        <div className="text-center mb-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
            <div>
              <h2 className="font-bold text-xl mb-4 flex items-center justify-center">
                <User className="mr-2 h-5 w-5" />
                Your Word:
              </h2>
              <div className="flex justify-center gap-2 mb-2">
                {/* {opponentSecretWord.split("").map((letter, index) => (
                  <motion.div
                    key={`your-letter-${index}`}
                    className="retro-letter retro-letter-secret-revealed"
                    initial={{ rotateY: 180 }}
                    animate={{ rotateY: 0 }}
                    transition={{ delay: index * 0.2, duration: 0.5 }}
                  >
                    {letter}
                  </motion.div>
                ))} */}
              </div>
            </div>

            <div>
              <h2 className="font-bold text-xl mb-4 flex items-center justify-center">
                <Users className="mr-2 h-5 w-5" />
                Opponent's Word:
              </h2>
              <div className="flex justify-center gap-2 mb-2">
                {/* {secretWord.split("").map((letter, index) => (
                  <motion.div
                    key={`opponent-letter-${index}`}
                    className={`retro-letter ${gameState === "won" ? "retro-letter-correct" : "retro-letter-secret-revealed"}`}
                    initial={{ rotateY: 180 }}
                    animate={{ rotateY: 0 }}
                    transition={{ delay: index * 0.2 + 0.5, duration: 0.5 }}
                  >
                    {letter}
                  </motion.div>
                ))} */}
              </div>
            </div>
          </div>

          {gameState === "won" && (
            <p className="text-xl font-bold text-retro-green mb-2">
              You guessed your opponent's word in {attempts}{" "}
              {attempts === 1 ? "try" : "tries"}!
            </p>
          )}

          {gameState === "draw" && (
            <p className="text-xl font-bold text-retro-blue mb-2">
              Both players guessed each other's words!
            </p>
          )}

          {gameState === "lost" && (
            <p className="text-xl font-bold text-retro-red mb-2">
              Your opponent guessed your word first!
            </p>
          )}
        </div>

        <div className="flex justify-center">
          <motion.button
            onClick={onPlayAgain}
            className="retro-button retro-button-primary text-xl px-8 py-4"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
          >
            Back to Dashboard
          </motion.button>
        </div>
      </motion.div>
    </div>
  );
}
