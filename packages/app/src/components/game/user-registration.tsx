import type React from "react";

import { useState } from "react";
import { motion } from "framer-motion";
import { useToast } from "../../hooks/use-toast";
import { Loader2 } from "lucide-react";
import { useScaffoldWriteContract } from "../../hooks/scaffold-stark/useScaffoldWriteContract";
import { usePlayerStore } from "../../stores/playerStore";

export default function PlayerRegistration() {
  const [username, setUsername] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<string[]>([]);
  const { setPlayerName } = usePlayerStore();
  const { toast } = useToast();

  const { sendAsync: registerPlayer } = useScaffoldWriteContract({
    contractName: "Mastermind",
    functionName: "register_player",
    args: [username],
  });

  const validateUsername = (value: string): string[] => {
    const errors: string[] = [];

    if (!value.trim()) {
      errors.push("Username cannot be empty");
    }

    if (value.length < 3) {
      errors.push("Username must be at least 3 characters long");
    }

    if (value.length > 15) {
      errors.push("Username must be less than 15 characters long");
    }

    // Check for valid characters (letters, numbers, underscores, hyphens)
    if (!/^[a-zA-Z0-9_-]+$/.test(value) && value.length > 0) {
      errors.push(
        "Username can only contain letters, numbers, underscores, and hyphens",
      );
    }

    return errors;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    const validationErrors = validateUsername(username);
    setErrors(validationErrors);

    if (validationErrors.length > 0) {
      return;
    }

    setIsLoading(true);

    try {
      await registerPlayer();
      toast({
        title: "Registration successful!",
        description: `Welcome to Word Mastermind, ${username}!`,
      });
    } catch (error) {
      toast({
        title: "Registration failed",
        description:
          "There was an error registering your username. Please try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-[80vh]">
      <motion.div
        className="retro-card max-w-md w-full"
        initial={{ scale: 0.9, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ duration: 0.3 }}
      >
        <h1 className="text-2xl md:text-3xl font-bold text-center text-retro-red drop-shadow-cartoon-text mb-6">
          Join Word Mastermind
        </h1>

        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="space-y-2">
            <label htmlFor="username" className="block text-lg font-bold">
              Choose Your Username
            </label>
            <input
              type="text"
              id="username"
              value={username}
              onChange={(e) => {
                setUsername(e.target.value);
                setErrors(validateUsername(e.target.value));
              }}
              className="retro-input w-full input"
              placeholder="Enter username"
              disabled={isLoading}
            />

            {errors.length > 0 && (
              <div className="text-retro-red text-sm mt-1">
                {errors.map((error, index) => (
                  <p key={index}>{error}</p>
                ))}
              </div>
            )}

            <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">
              Your username will be visible to other players.
            </p>
          </div>

          <button
            type="submit"
            className="retro-button retro-button-primary w-full py-3"
            disabled={isLoading}
          >
            {isLoading ? (
              <>
                <Loader2 className="h-5 w-5 mr-2 animate-spin" />
                Registering...
              </>
            ) : (
              "Start Playing!"
            )}
          </button>
        </form>
      </motion.div>
    </div>
  );
}
