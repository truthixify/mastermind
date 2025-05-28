import { useState, useEffect, useRef } from 'react'
import vkUrl from './assets/vk.bin?url'
import initNoirC from '@noir-lang/noirc_abi'
import initACVM from '@noir-lang/acvm_js'
import acvm from '@noir-lang/acvm_js/web/acvm_js_bg.wasm?url'
import noirc from '@noir-lang/noirc_abi/web/noirc_abi_wasm_bg.wasm?url'
import { useScaffoldReadContract } from './hooks/scaffold-stark/useScaffoldReadContract'
import { useAccount } from './hooks/useAccount'
import { usePlayerStore } from './stores/playerStore'
import GameContainer from './components/game/game-container'
import PlayerRegistration from './components/game/user-registration'
import { feltToString } from './utils/utils'
import { Buffer } from 'buffer'
import { toast } from './hooks/use-toast'
import { useDictionary } from './context/dictionary'

window.Buffer = Buffer

function App() {
    const [vk, setVk] = useState<Uint8Array | null>(null)
    const { setPlayerName } = usePlayerStore()
    const dictionary = useDictionary()
    const { address } = useAccount()

    const { data: getPlayerName } = useScaffoldReadContract({
        contractName: 'Mastermind',
        functionName: 'get_player_name',
        args: [address]
    })

    // Load dictionary once when the app mounts
    useEffect(() => {
        dictionary.load()
    }, [dictionary])

    useEffect(() => {
        setPlayerName(feltToString(getPlayerName))
    }, [])

    // Initialize WASM on component mount
    useEffect(() => {
        const initWasm = async () => {
            try {
                // This might have already been initialized in main.tsx,
                // but we're adding it here as a fallback
                if (typeof window !== 'undefined') {
                    await Promise.all([initACVM(fetch(acvm)), initNoirC(fetch(noirc))])
                    console.log('WASM initialization in App complete')
                }
            } catch (error) {
                toast({
                    title: 'Load WASM error',
                    description: "'Failed to initialize WASM in App",
                    variant: 'destructive'
                })
                console.error('Failed to initialize WASM in App component:', error)
            }
        }

        const loadVk = async () => {
            const response = await fetch(vkUrl)
            const arrayBuffer = await response.arrayBuffer()
            const binaryData = new Uint8Array(arrayBuffer)
            setVk(binaryData)
            // console.log('Loaded verifying key:', binaryData);
        }

        initWasm()
        loadVk()
    }, [])

    return <>{getPlayerName !== 0n ? <GameContainer /> : <PlayerRegistration />}</>
}

export default App
