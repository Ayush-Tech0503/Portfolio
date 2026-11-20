import { useState, type CSSProperties } from 'react';
import { ImageOff } from 'lucide-react';

interface ResilientImageProps {
  src: string;
  alt: string;
  className?: string;
  style?: CSSProperties;
  loading?: 'lazy' | 'eager';
}

export function ResilientImage({
  src,
  alt,
  className = '',
  style,
  loading = 'eager',
}: ResilientImageProps) {
  const [hasError, setHasError] = useState(false);

  if (hasError) {
    return (
      <div
        role="img"
        aria-label={alt}
        className={`flex flex-col items-center justify-center gap-2 bg-[#16171A] border border-white/10 text-[#D7E2EA]/50 px-4 text-center ${className}`}
        style={style}
      >
        <ImageOff className="w-6 h-6 opacity-60" aria-hidden="true" />
        <span className="text-xs font-medium tracking-wide uppercase opacity-75 max-w-[200px] truncate">
          {alt}
        </span>
      </div>
    );
  }

  return (
    <img
      src={src}
      alt={alt}
      loading={loading}
      referrerPolicy="no-referrer"
      onError={() => setHasError(true)}
      className={className}
      style={style}
    />
  );
}
