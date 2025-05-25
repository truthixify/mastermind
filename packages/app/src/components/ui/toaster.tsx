import {
  Toast,
  ToastClose,
  ToastDescription,
  ToastProvider,
  ToastTitle,
  ToastViewport,
} from "./toast";
import { useToast } from "../../hooks/use-toast";

export function Toaster() {
  const { toasts } = useToast();

  return (
    <ToastProvider>
      {toasts.map(({ id, title, description, action, ...props }) => (
        <Toast
          key={id}
          {...props}
          className="retro-card border-cartoon border-black dark:border-gray-700"
        >
          <div className="grid gap-1">
            {title && <ToastTitle className="font-cartoon">{title}</ToastTitle>}
            {description && <ToastDescription>{description}</ToastDescription>}
          </div>
          {action}
          <ToastClose className="retro-button p-1 h-8 w-8 flex items-center justify-center" />
        </Toast>
      ))}
      <ToastViewport />
    </ToastProvider>
  );
}
