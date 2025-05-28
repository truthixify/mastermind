import { motion } from "framer-motion";
import Confetti from "react-confetti";
import { useWindowSize } from "../../hooks/use-window-size";
import { useState, useEffect } from "react";
import { User, Users } from "lucide-react";
import { addAddressPadding, CairoCustomEnum } from "starknet";
import { useAccount } from "../../hooks/useAccount";
import { feltToHex } from "../../utils/scaffold-stark/common";

interface GameOverScreenProps {
  gameResult: CairoCustomEnum | undefined;
  revealedSolution: string | undefined;
  opponentRevealedSolution: string | undefined;
  isRevealed: boolean;
  onRevealSolution: () => void;
  onPlayAgain: () => void;
}

export default function GameOverScreen({
  gameResult,
  revealedSolution,
  opponentRevealedSolution,
  isRevealed,
  onRevealSolution,
  onPlayAgain,
}: GameOverScreenProps) {
  const { width, height } = useWindowSize();
  const [showConfetti, setShowConfetti] = useState(
    gameResult?.activeVariant() === "Win" ||
      gameResult?.activeVariant() === "Tie",
  );
  const { address } = useAccount();

  // Stop confetti after 5 seconds
  useEffect(() => {
    if (
      gameResult?.activeVariant() === "Win" ||
      gameResult?.activeVariant() === "Tie"
    ) {
      const timer = setTimeout(() => {
        setShowConfetti(false);
      }, 15000);

      return () => clearTimeout(timer);
    }
  }, []);

  return (
    <div className="retro-container flex flex-col items-center justify-center min-h-screen">
      {showConfetti && (
        <Confetti width={width} height={height} recycle={false} />
      )}

      <motion.h1
        className={`retro-title text-4xl md:text-6xl mb-8 ${
          gameResult?.activeVariant() === "Win"
            ? "text-retro-green"
            : gameResult?.activeVariant() === "Tie"
              ? "text-retro-blue"
              : "text-retro-red"
        }`}
        initial={{ scale: 0.5, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ type: "spring", stiffness: 300, damping: 15 }}
      >
        {gameResult?.activeVariant() === "Win"
          ? gameResult?.unwrap() &&
            address === addAddressPadding(feltToHex(gameResult?.unwrap()))
            ? "You Won!"
            : "You Lost!"
          : gameResult?.activeVariant() === "Tie"
            ? "It's a Tie!"
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
                {revealedSolution
                  ? revealedSolution.split("").map((letter, index) => (
                      <motion.div
                        key={`your-letter-${index}`}
                        className="retro-letter retro-letter-secret-revealed"
                        initial={{ rotateY: 180 }}
                        animate={{ rotateY: 0 }}
                        transition={{ delay: index * 0.2, duration: 0.5 }}
                      >
                        {letter}
                      </motion.div>
                    ))
                  : ["?", "?", "?", "?"].map((letter, index) => (
                      <motion.div
                        key={`your-letter-placeholder-${index}`}
                        className="retro-letter retro-letter-placeholder"
                        initial={{ rotateY: 180 }}
                        animate={{ rotateY: 0 }}
                        transition={{ delay: index * 0.2, duration: 0.5 }}
                      >
                        {letter}
                      </motion.div>
                    ))}
              </div>
            </div>

            <div>
              <h2 className="font-bold text-xl mb-4 flex items-center justify-center">
                <Users className="mr-2 h-5 w-5" />
                Opponent's Word:
              </h2>
              <div className="flex justify-center gap-2 mb-2">
                {opponentRevealedSolution
                  ? opponentRevealedSolution.split("").map((letter, index) => (
                      <motion.div
                        key={`opponent-letter-${index}`}
                        className={`retro-letter ${gameResult?.activeVariant() === "Win" ? "retro-letter-correct" : "retro-letter-secret-revealed"}`}
                        initial={{ rotateY: 180 }}
                        animate={{ rotateY: 0 }}
                        transition={{ delay: index * 0.2 + 0.5, duration: 0.5 }}
                      >
                        {letter}
                      </motion.div>
                    ))
                  : ["?", "?", "?", "?"].map((letter, index) => (
                      <motion.div
                        key={`opponent-letter-placeholder-${index}`}
                        className="retro-letter retro-letter-placeholder"
                        initial={{ rotateY: 180 }}
                        animate={{ rotateY: 0 }}
                        transition={{ delay: index * 0.2 + 0.5, duration: 0.5 }}
                      >
                        {letter}
                      </motion.div>
                    ))}
              </div>
            </div>
          </div>
        </div>

        <div className="flex justify-between gap-2">
          <motion.button
            onClick={onPlayAgain}
            className="retro-button retro-button-primary text-xl px-8 py-4"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            disabled={!isRevealed}
          >
            Back to Dashboard
          </motion.button>
          <motion.button
            onClick={onRevealSolution}
            className="retro-button retro-button-secondary text-xl px-8 py-4"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
          >
            Reveal Solution
          </motion.button>
        </div>
      </motion.div>
    </div>
  );
}
