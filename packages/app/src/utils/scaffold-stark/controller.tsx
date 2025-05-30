import { Chain } from '@starknet-react/chains'
import {
    jsonRpcProvider,
    publicProvider,
    starknetChainId,
    InjectedConnector
} from '@starknet-react/core'
import { constants } from 'starknet'
import scaffoldConfig from '../../../scaffold.config'
import ControllerConnector from '@cartridge/connector/controller'
import { SessionPolicies } from '@cartridge/presets'

// Standard contract addresses
export const MASTERMIND_CONTRACT_ADDRESS =
    '0xd8008b0dde070b66edd2d6e0def1a389d323797ab85eb652425173853a03e4'

// Function to check for devnet networks
const containsDevnet = (networks: readonly Chain[]) => {
    return networks.some(it => it.network === 'devnet')
}

// Provider configuration based on Scaffold settings
export const getProvider = () => {
    if (scaffoldConfig.rpcProviderUrl.sepolia || containsDevnet(scaffoldConfig.targetNetworks)) {
        return publicProvider()
    }

    return jsonRpcProvider({
        rpc: () => ({
            nodeUrl: scaffoldConfig.rpcProviderUrl.sepolia,
            chainId: starknetChainId(scaffoldConfig.targetNetworks[0].id)
        })
    })
}

// Supported chains configuration
const chains = [
    {
        id: constants.StarknetChainId.SN_SEPOLIA,
        name: 'Sepolia',
        rpcUrl:
            import.meta.env.VITE_NEXT_PUBLIC_RPC_SEPOLIA ?? 'https://api.cartridge.gg/x/starknet/sepolia'
    },
    {
        id: constants.StarknetChainId.SN_MAIN,
        name: 'Mainnet',
        rpcUrl:
            import.meta.env.VITE_NEXT_PUBLIC_SEPOLIA_PROVIDER_URL ?? 'https://api.cartridge.gg/x/starknet/mainnet'
    }
]

// Session policies for contracts
const policies: SessionPolicies = {
    contracts: {
        [MASTERMIND_CONTRACT_ADDRESS]: {
            methods: [
                { name: 'register_player', entrypoint: 'register_player' },
                { name: 'init_game', entrypoint: 'init_game' },
                { name: 'join_game', entrypoint: 'join_game' },
                { name: 'submit_guess', entrypoint: 'submit_guess' },
                { name: 'commit_solution_hash', entrypoint: 'commit_solution_hash' },
                { name: 'submit_hit_and_blow_proof', entrypoint: 'submit_hit_and_blow_proof' },
                { name: 'reveal_solution', entrypoint: 'reveal_solution' }
            ]
        }
    }
}

// Create Cartridge Controller instance
export const controllerInstance = new ControllerConnector({
    policies,
    defaultChainId: constants.StarknetChainId.SN_SEPOLIA,
    chains: chains,
    url: import.meta.env.NEXT_PUBLIC_KEYCHAIN_DEPLOYMENT_URL,
    profileUrl: import.meta.env.NEXT_PUBLIC_PROFILE_DEPLOYMENT_URL
}) as unknown as InjectedConnector
