// @refresh reset

import { AddressInfoDropdown } from './AddressInfoDropdown'
import { WrongNetworkDropdown } from './WrongNetworkDropdown'
import { useAutoConnect } from '../../../hooks/scaffold-stark'
import { useTargetNetwork } from '../../../hooks/scaffold-stark/useTargetNetwork'
import { getBlockExplorerAddressLink } from '../../../utils/scaffold-stark'
import { useAccount, useConnect } from '@starknet-react/core'
import { Address } from '@starknet-react/chains'
import { useEffect, useMemo, useState } from 'react'
import ConnectModal from './ConnectModal'

/**
 * Custom Connect Button (watch balance + custom design)
 */
export const CustomConnectButton = () => {
    useAutoConnect()
    const { connector } = useConnect()
    const { targetNetwork } = useTargetNetwork()
    const { account, status, address: accountAddress } = useAccount()
    const [accountChainId, setAccountChainId] = useState<bigint>(0n)

    const blockExplorerAddressLink = useMemo(() => {
        return accountAddress && getBlockExplorerAddressLink(targetNetwork, accountAddress)
    }, [accountAddress, targetNetwork])

    // effect to get chain id and address from account
    useEffect(() => {
        if (account) {
            const getChainId = async () => {
                const chainId = await account.channel.getChainId()
                setAccountChainId(BigInt(chainId as string))
            }

            getChainId()
        }
    }, [account, status])

    useEffect(() => {
        const handleChainChange = (event: { chainId?: bigint }) => {
            const { chainId } = event
            if (chainId && chainId !== accountChainId) {
                setAccountChainId(chainId)
            }
        }
        connector?.on('change', handleChainChange)
        return () => {
            connector?.off('change', handleChainChange)
        }
    }, [connector])

    if (status === 'disconnected' || accountChainId === 0n) return <ConnectModal />

    if (accountChainId !== targetNetwork.id) {
        return <WrongNetworkDropdown />
    }

    return (
        <>
            <AddressInfoDropdown
                address={accountAddress as Address}
                displayName={''}
                ensAvatar={''}
                blockExplorerAddressLink={blockExplorerAddressLink}
            />
        </>
    )
}
