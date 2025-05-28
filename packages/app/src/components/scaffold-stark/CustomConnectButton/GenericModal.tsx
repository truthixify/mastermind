import { motion } from 'framer-motion'

const GenericModal = ({
    children,
    className = 'modal-box modal-border bg-modal rounded-[8px] border flex flex-col gap-3 justify-around relative',
    onClose
}: {
    children: React.ReactNode
    className?: string
    onClose?: () => void
}) => {
    return (
        <div
            className="fixed inset-0 z-50 flex items-center justify-center backdrop-blur bg-black/40"
            onClick={onClose}
        >
            <motion.div
                onClick={e => e.stopPropagation()}
                className="retro-card max-w-md w-full z-10 p-6"
                initial={{ scale: 0.9, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                exit={{ scale: 0.9, opacity: 0 }}
                transition={{ duration: 0.3 }}
            >
                {children}
            </motion.div>
        </div>
    )
}

export default GenericModal
