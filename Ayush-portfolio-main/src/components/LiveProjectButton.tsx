interface LiveProjectButtonProps {
  onClick?: () => void;
  className?: string;
}

export function LiveProjectButton({ onClick, className = '' }: LiveProjectButtonProps) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={`rounded-full border-2 border-[#D7E2EA] text-[#D7E2EA] font-medium uppercase tracking-widest px-8 py-3 sm:px-10 sm:py-3.5 text-sm sm:text-base whitespace-nowrap shrink-0 cursor-pointer transition-colors duration-200 hover:bg-[#D7E2EA]/10 focus-visible:outline-2 focus-visible:outline-[#D7E2EA] focus-visible:outline-offset-2 ${className}`}
    >
      Live Project
    </button>
  );
}
