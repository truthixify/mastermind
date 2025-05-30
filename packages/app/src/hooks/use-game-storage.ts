type GameData = {
    solution: number[]
    salt: string
    gameId: number
}

type UseGameStorageReturn = {
    setGameData: (value: GameData) => void
    getGameData: (id: number) => GameData | null
}

export function useGameStorage(storageKey: string): UseGameStorageReturn {
    const getGameData = (id: number): GameData | null => {
        if (typeof window === 'undefined') return null
        try {
            const raw = window.localStorage.getItem(storageKey)
            const allData: Record<string, GameData> = raw ? JSON.parse(raw) : {}
            return allData[String(id)] ?? null
        } catch {
            return null
        }
    }

    const setGameData = (value: GameData) => {
        if (typeof window === 'undefined') return
        try {
            const raw = window.localStorage.getItem(storageKey)
            const allData: Record<string, GameData> = raw ? JSON.parse(raw) : {}
            const updated = { ...allData, [String(value.gameId)]: value }
            window.localStorage.setItem(storageKey, JSON.stringify(updated))
        } catch {}
    }

    return { getGameData, setGameData }
}
