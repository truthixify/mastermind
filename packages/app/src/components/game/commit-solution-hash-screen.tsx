import type React from "react";
import { useState } from "react";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "../ui/card";
import { Button } from "../ui/button";
import { Input } from "../ui/input";
import { useToast } from "../../hooks/use-toast";
import { AlertCircle, ArrowLeft } from "lucide-react";
import { BigNumberish, uint256, Uint256 } from "starknet";
import { MaxUint256, randomBytes } from "ethers";
import { ReloadIcon } from "@radix-ui/react-icons";
import { useScaffoldWriteContract } from "../../hooks/scaffold-stark/useScaffoldWriteContract";
import { useGameStore } from "../../stores/gameStore";
import { WordDictionary } from "../../lib/dict";
import { useGameStorage } from "../../hooks/use-game-storage";
import { poseidonHashBN254, init } from "garaga";

interface CommitSolutionHashProps {
  onCommit: () => void;
  isMobile: boolean;
  onBack: () => void;
}

const randomBigInt = (num_bytes: number = 31) => {
  const randomByte = randomBytes(num_bytes);
  let hexString = Buffer.from(randomByte).toString("hex");
  let randomU256: BigNumberish = BigInt("0x" + hexString) % MaxUint256;

  return randomU256;
};

export default function CommitSolutionHash({
  onCommit,
  isMobile,
  onBack,
}: CommitSolutionHashProps) {
  const [secretWord, setSecretWord] = useState("");
  const [salt, setSalt] = useState<Uint256>(() =>
    uint256.bnToUint256(randomBigInt()),
  );
  const [solutionHash, setSolutionHash] = useState<BigNumberish>();
  const { toast } = useToast();

  const { gameId } = useGameStore();
  const { setGameData } = useGameStorage("game-data", gameId);

  const dict = new WordDictionary();
  dict.load();

  const { sendAsync: CommitSolutionHash } = useScaffoldWriteContract({
    contractName: "Mastermind",
    functionName: "commit_solution_hash",
    args: [gameId, solutionHash],
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    const word = secretWord.trim().toUpperCase();
    const solutionArray = word.split("").map((letter) => letter.charCodeAt(0));
    const prepSolution =
      solutionArray[0] +
      solutionArray[1] * 256 +
      solutionArray[2] * 256 * 256 +
      solutionArray[3] * 256 * 256 * 256;

    await init();
    let poseidonHashRes = poseidonHashBN254(
      BigInt(prepSolution),
      uint256.uint256ToBN(salt),
    );
    setSolutionHash(poseidonHashRes);

    // Validate word
    if (word.length !== 4) {
      toast({
        title: "Invalid word",
        description: "Your secret word must be exactly 4 letters long.",
        variant: "destructive",
      });
      return;
    }

    if (!dict.hasWord(word)) {
      toast({
        title: "Invalid word",
        description:
          "Your secret word must contain unique letters and must be in dictionary",
        variant: "destructive",
      });
      return;
    }

    const res = await CommitSolutionHash();

    if (res) {
      if (gameId !== undefined) {
        setGameData({
          solution: solutionArray,
          salt: uint256.uint256ToBN(salt).toString(),
          gameId: Number(gameId),
        });
      }
      onCommit();
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen p-4">
      <Card className={`${isMobile ? "w-full" : "w-full max-w-md"}`}>
        <CardHeader>
          <CardTitle className="text-2xl text-center">
            Set Your Secret Word
          </CardTitle>
          <CardDescription className="text-center">
            Choose a 4-letter word with unique letters that your opponent will
            try to guess
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <div className="w-full flex justify-between">
                <h2 className="card-title">Salt</h2>
                <div className="card-actions">
                  <Button type="button" variant="link">
                    <ReloadIcon
                      onClick={() =>
                        setSalt(uint256.bnToUint256(randomBigInt()))
                      }
                    />
                  </Button>
                </div>
              </div>
              <p className="w-full break-words">{uint256.uint256ToBN(salt)}</p>
            </div>
            <div className="space-y-2">
              <div className="text-sm font-medium">Secret Word (4 letters)</div>
              <Input
                placeholder="Enter your secret word"
                value={secretWord}
                onChange={(e) => setSecretWord(e.target.value.toUpperCase())}
                className="font-mono text-center text-lg uppercase"
                maxLength={4}
              />
              <div className="flex items-start text-xs text-slate-500 dark:text-slate-400">
                <AlertCircle className="h-4 w-4 mr-1 mt-0.5 flex-shrink-0" />
                <span>
                  Your word must have 4 unique letters (no repeats). This word
                  will be hidden from your opponent until the game ends.
                </span>
              </div>
            </div>
            <Button type="submit" className="w-full">
              Confirm Secret Word
            </Button>
          </form>
        </CardContent>
        <CardFooter className="flex justify-center">
          <Button variant="ghost" size="sm" onClick={onBack}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Back to Dashboard
          </Button>
        </CardFooter>
      </Card>
    </div>
  );
}
