// @ts-nocheck
import { Connector, useConnect } from '@starknet-react/core'
import { useState } from 'react'
import Wallet from '../../scaffold-stark/CustomConnectButton/Wallet'
import { useLocalStorage } from 'usehooks-ts'
import { BurnerConnector, burnerAccounts } from '@scaffold-stark/stark-burner'
import { BlockieAvatar } from '../BlockieAvatar'
import GenericModal from './GenericModal'
import { LAST_CONNECTED_TIME_LOCALSTORAGE_KEY } from '../../../utils/Constants'
import { Button } from '../../ui/button'
import { motion } from 'framer-motion'
import { X } from 'lucide-react'

const loader = ({ src }: { src: string }) => {
    return src
}

const ConnectModal = () => {
    const [showModal, setShowModal] = useState(false)
    // const modalRef = useRef<HTMLInputElement>(null)
    const [isBurnerWallet, setIsBurnerWallet] = useState(false)
    // const { resolvedTheme } = useTheme()
    // const isDarkMode = resolvedTheme === 'dark'
    const { connectors, connect, status } = useConnect()
    const [_, setLastConnector] = useLocalStorage<{ id: string; ix?: number }>(
        'lastUsedConnector',
        { id: '' },
        {
            initializeWithValue: false
        }
    )
    const [, setLastConnectionTime] = useLocalStorage<number>(
        LAST_CONNECTED_TIME_LOCALSTORAGE_KEY,
        0
    )

    // const handleCloseModal = () => {
    //   if (modalRef.current) {
    //     modalRef.current.checked = false;
    //   }
    // };
    const openModal = () => setShowModal(true)
    const closeModal = () => setShowModal(false)

    // Replace `handleCloseModal` usage:
    const handleCloseModal = closeModal

    function handleConnectWallet(
        e: React.MouseEvent<HTMLButtonElement>,
        connector: Connector
    ): void {
        if (connector.id === 'burner-wallet') {
            setIsBurnerWallet(true)
            return
        }
        connect({ connector })
        setLastConnector({ id: connector.id })
        setLastConnectionTime(Date.now())
        handleCloseModal()
    }

    function handleConnectBurner(e: React.MouseEvent<HTMLButtonElement>, ix: number) {
        const connector = connectors.find(it => it.id == 'burner-wallet')
        if (connector && connector instanceof BurnerConnector) {
            connector.burnerAccount = burnerAccounts[ix]
            connect({ connector })
            setLastConnector({ id: connector.id, ix })
            setLastConnectionTime(Date.now())
            handleCloseModal()
        }
    }

    return (
        <div>
            <Button
                variant="outline"
                onClick={openModal}
                className={`retro-button retro-button-outline py-1 px-3 md:py-2 md:px-4 flex items-center gap-2 ${
                    status === 'success' ? 'bg-retro-green text-white' : ''
                }`}
                disabled={status === 'pending'}
            >
                {status === 'pending' ? (
                    <>
                        <div className="animate-spin h-4 w-4 border-2 border-current border-t-transparent rounded-full mr-2"></div>
                        Connecting...
                    </>
                ) : status === 'success' ? (
                    'Connected'
                ) : (
                    <>Connect</>
                )}
            </Button>

            {showModal && (
                <GenericModal onClose={closeModal}>
                    <div className="flex items-center justify-between mb-6">
                        <h3 className="text-xl font-bold text-retro-blue drop-shadow-cartoon-text">
                            {isBurnerWallet ? 'Choose Account' : 'Connect Wallet'}
                        </h3>
                        <button
                            onClick={() => {
                                setIsBurnerWallet(false)
                                closeModal()
                            }}
                            className="retro-button retro-button-outline p-2 h-10 w-10 flex items-center justify-center"
                        >
                            <X className="h-4 w-4" />
                        </button>
                    </div>

                    <div className="flex flex-col gap-4">
                        {!isBurnerWallet ? (
                            // Wallet options
                            connectors.map((connector, index) => (
                                <Wallet
                                    key={connector.id || index}
                                    connector={connector}
                                    loader={loader}
                                    handleConnectWallet={handleConnectWallet}
                                />
                            ))
                        ) : (
                            // Burner wallet accounts
                            <div className="flex flex-col gap-3">
                                <div className="max-h-[300px] overflow-y-auto flex w-full flex-col gap-2">
                                    {burnerAccounts.map((burnerAcc, ix) => (
                                        <motion.button
                                            key={burnerAcc.publicKey}
                                            whileHover={{ scale: 1.02 }}
                                            whileTap={{ scale: 0.98 }}
                                            className="retro-button retro-button-outline w-full py-3 px-4 flex items-center gap-3"
                                            onClick={e => handleConnectBurner(e, ix)}
                                        >
                                            <BlockieAvatar
                                                address={burnerAcc.accountAddress}
                                                size={35}
                                            />
                                            <span className="font-bold">
                                                {`${burnerAcc.accountAddress.slice(0, 6)}...${burnerAcc.accountAddress.slice(-4)}`}
                                            </span>
                                        </motion.button>
                                    ))}
                                </div>
                            </div>
                        )}
                    </div>

                    {isBurnerWallet && (
                        <div className="mt-4 flex justify-start">
                            <button
                                onClick={() => setIsBurnerWallet(false)}
                                className="retro-button retro-button-secondary py-2 px-4 flex items-center gap-2"
                            >
                                Back to Wallets
                            </button>
                        </div>
                    )}
                </GenericModal>
            )}
        </div>
    )
}

export default ConnectModal
