import { useScaffoldReadContract } from "../hooks/scaffold-stark/useScaffoldReadContract";
import { feltToString } from "../utils/utils";

export const usePlayerName = (address: string) => {
  const { data } = useScaffoldReadContract({
    contractName: "Mastermind",
    functionName: "get_player_name",
    args: [address],
  });

  return feltToString(data);
};
