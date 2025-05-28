import { Button } from './ui/button'
import { Moon, Sun, Wallet } from 'lucide-react'
import { motion } from 'framer-motion'
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from './ui/tooltip'
import { useCallback, useRef, useState, useEffect } from 'react'
import { useOutsideClick } from '../hooks/scaffold-stark'
import { CustomConnectButton } from './scaffold-stark/CustomConnectButton'
import { useTheme } from 'next-themes'
import { useTargetNetwork } from '../hooks/scaffold-stark/useTargetNetwork'
import { devnet } from '@starknet-react/chains'
import { useAccount, useNetwork, useProvider } from '@starknet-react/core'

export function Header() {
    const { theme, setTheme } = useTheme()
    const [isDrawerOpen, setIsDrawerOpen] = useState(false)
    const burgerMenuRef = useRef<HTMLDivElement>(null)

    useOutsideClick(
        burgerMenuRef,
        useCallback(() => setIsDrawerOpen(false), [])
    )

    const { targetNetwork } = useTargetNetwork()
    const isLocalNetwork = targetNetwork.network === devnet.network

    const { provider } = useProvider()
    const { address, status, chainId } = useAccount()
    const { chain } = useNetwork()
    const [isDeployed, setIsDeployed] = useState(true)

    useEffect(() => {
        if (
            status === 'connected' &&
            address &&
            chainId === targetNetwork.id &&
            chain.network === targetNetwork.network
        ) {
            provider
                .getClassHashAt(address)
                .then(classHash => {
                    if (classHash) setIsDeployed(true)
                    else setIsDeployed(false)
                })
                .catch(e => {
                    console.error('contract check', e)
                    if (e.toString().includes('Contract not found')) {
                        setIsDeployed(false)
                    }
                })
        }
    }, [status, address, provider, chainId, targetNetwork.id, targetNetwork.network, chain.network])

    return (
        <header className="w-full py-4 px-4 md:px-8 flex justify-between items-center">
            <div className="flex items-center">
                <motion.h1
                    className="text-xl md:text-2xl font-bold text-retro-red drop-shadow-cartoon-text"
                    initial={{ opacity: 0, y: -20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.3 }}
                >
                    Mastermind
                </motion.h1>
            </div>

            <div className="flex items-center gap-2 md:gap-4">
                <TooltipProvider>
                    <Tooltip>
                        <TooltipTrigger asChild>
                            <motion.div
                                initial={{ opacity: 0, scale: 0.8 }}
                                animate={{ opacity: 1, scale: 1 }}
                                transition={{ duration: 0.3, delay: 0.1 }}
                            >
                                <CustomConnectButton />
                            </motion.div>
                        </TooltipTrigger>
                        {status === 'connected' && !isDeployed ? (
                            <TooltipContent>
                                <span className="bg-[#8a45fc] text-[9px] p-1 text-white">
                                    Wallet Not Deployed
                                </span>
                            </TooltipContent>
                        ) : null}
                    </Tooltip>
                </TooltipProvider>

                <TooltipProvider>
                    <Tooltip>
                        <TooltipTrigger asChild>
                            <motion.div
                                initial={{ opacity: 0, scale: 0.8 }}
                                animate={{ opacity: 1, scale: 1 }}
                                transition={{ duration: 0.3, delay: 0.2 }}
                            >
                                <Button
                                    onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
                                    variant="outline"
                                    className="retro-button retro-button-outline py-1 px-2"
                                >
                                    {theme === 'dark' ? (
                                        <Sun className="h-4 w-4" />
                                    ) : (
                                        <Moon className="h-4 w-4" />
                                    )}
                                    <span className="sr-only">Toggle theme</span>
                                </Button>
                            </motion.div>
                        </TooltipTrigger>
                        <TooltipContent>
                            Switch to {theme === 'dark' ? 'light' : 'dark'} mode
                        </TooltipContent>
                    </Tooltip>
                </TooltipProvider>
            </div>
        </header>
    )
}
