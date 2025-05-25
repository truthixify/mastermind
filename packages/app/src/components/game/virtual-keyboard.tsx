import { motion } from "framer-motion";

interface VirtualKeyboardProps {
  onKeyPress: (key: string) => void;
  guesses: string[];
  feedback: Array<Array<"correct" | "partial" | "incorrect">>;
  disabled?: boolean;
}

export default function VirtualKeyboard({
  onKeyPress,
  guesses,
  feedback,
  disabled = false,
}: VirtualKeyboardProps) {
  // Keyboard layout
  const rows = [
    ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
    ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
    ["Enter", "Z", "X", "C", "V", "B", "N", "M", "Backspace"],
  ];

  // Track letter statuses based on feedback
  const letterStatus: Record<
    string,
    "correct" | "partial" | "incorrect" | "unused"
  > = {};

  // Initialize all letters as unused
  "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("").forEach((letter) => {
    letterStatus[letter] = "unused";
  });

  // Update letter statuses based on feedback
  guesses.forEach((guess, guessIndex) => {
    guess.split("").forEach((letter, letterIndex) => {
      const status = feedback[guessIndex][letterIndex];

      // Only upgrade status (unused -> incorrect -> partial -> correct)
      if (
        letterStatus[letter] === "unused" ||
        (letterStatus[letter] === "incorrect" && status !== "incorrect") ||
        (letterStatus[letter] === "partial" && status === "correct")
      ) {
        letterStatus[letter] = status;
      }
    });
  });

  // Get class for key based on its status
  const getKeyClass = (key: string) => {
    if (disabled) {
      return "retro-key-disabled";
    }

    if (key === "Enter" || key === "Backspace") {
      return "retro-key-action";
    }

    switch (letterStatus[key]) {
      case "correct":
        return "retro-key-correct";
      case "partial":
        return "retro-key-partial";
      case "incorrect":
        return "retro-key-incorrect";
      default:
        return "retro-key-unused";
    }
  };

  return (
    <div className={`retro-keyboard ${disabled ? "opacity-70" : ""}`}>
      {rows.map((row, rowIndex) => (
        <div key={`row-${rowIndex}`} className="flex justify-center gap-1 mb-1">
          {row.map((key) => (
            <motion.button
              key={key}
              className={`retro-key ${getKeyClass(key)}`}
              onClick={() => !disabled && onKeyPress(key)}
              whileTap={{ scale: disabled ? 1 : 0.95 }}
              disabled={disabled}
            >
              {key === "Backspace" ? "⌫" : key}
            </motion.button>
          ))}
        </div>
      ))}
    </div>
  );
}
