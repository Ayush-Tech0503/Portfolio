import { PROFILE } from '../data/portfolio';

interface SocialLinksProps {
  size?: 'sm' | 'md';
  className?: string;
}

export function SocialLinks({ size = 'md', className = '' }: SocialLinksProps) {
  const dimensionClass = size === 'sm' ? 'w-9 h-9' : 'w-11 h-11';
  const iconClass = size === 'sm' ? 'w-4 h-4' : 'w-5 h-5';

  return (
    <div className={`flex items-center gap-3 ${className}`}>
      <a
        href={PROFILE.linkedinUrl}
        target="_blank"
        rel="noopener noreferrer"
        aria-label="LinkedIn"
        title="LinkedIn"
        className={`${dimensionClass} rounded-full border border-[#D7E2EA]/40 text-[#D7E2EA] flex items-center justify-center transition-colors duration-200 hover:border-[#D7E2EA] hover:bg-[#D7E2EA]/10 focus-visible:outline-2 focus-visible:outline-[#D7E2EA] focus-visible:outline-offset-2`}
      >
        <svg
          viewBox="0 0 24 24"
          fill="currentColor"
          className={iconClass}
          aria-hidden="true"
        >
          <path d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.28 1.3v-1.11h-2.79v8.37h2.79v-4.93c0-.77.62-1.4 1.39-1.4a1.4 1.4 0 0 1 1.4 1.4v4.93h2.75M6.88 8.56a1.68 1.68 0 0 0 1.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 0 0-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37h2.77z" />
        </svg>
      </a>

      <a
        href={PROFILE.instagramUrl}
        target="_blank"
        rel="noopener noreferrer"
        aria-label="Instagram"
        title="Instagram"
        className={`${dimensionClass} rounded-full border border-[#D7E2EA]/40 text-[#D7E2EA] flex items-center justify-center transition-colors duration-200 hover:border-[#D7E2EA] hover:bg-[#D7E2EA]/10 focus-visible:outline-2 focus-visible:outline-[#D7E2EA] focus-visible:outline-offset-2`}
      >
        <svg
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          strokeWidth="1.9"
          strokeLinecap="round"
          strokeLinejoin="round"
          className={iconClass}
          aria-hidden="true"
        >
          <rect width="20" height="20" x="2" y="2" rx="5" ry="5" />
          <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z" />
          <line x1="17.5" x2="17.51" y1="6.5" y2="6.5" />
        </svg>
      </a>

      <a
        href={PROFILE.substackUrl}
        target="_blank"
        rel="noopener noreferrer"
        aria-label="Substack"
        title="Substack"
        className={`${dimensionClass} rounded-full border border-[#D7E2EA]/40 text-[#D7E2EA] flex items-center justify-center transition-colors duration-200 hover:border-[#D7E2EA] hover:bg-[#D7E2EA]/10 focus-visible:outline-2 focus-visible:outline-[#D7E2EA] focus-visible:outline-offset-2`}
      >
        <svg
          viewBox="0 0 24 24"
          fill="currentColor"
          className={iconClass}
          aria-hidden="true"
        >
          <path d="M22.539 8.242H1.46V5.406h21.08v2.836zM1.46 10.812V24L12 18.11 22.54 24V10.812H1.46zM22.54 0H1.46v2.836h21.08V0z" />
        </svg>
      </a>
    </div>
  );
}
