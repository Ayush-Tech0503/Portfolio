import { FadeIn } from './FadeIn';
import { Magnet } from './Magnet';
import { ContactButton } from './ContactButton';
import { ResilientImage } from './ResilientImage';
import { PROFILE } from '../data/portfolio';

interface HeroSectionProps {
  onOpenContact: () => void;
}

export function HeroSection({ onOpenContact }: HeroSectionProps) {
  const scrollToSection = (id: string) => {
    const target = document.getElementById(id);
    if (target) {
      target.scrollIntoView({ behavior: 'smooth' });
    }
  };

  return (
    <section
      className="h-[100svh] flex flex-col justify-between relative bg-[#0C0C0C] overflow-hidden"
      style={{ overflowX: 'clip' }}
    >
      {/* Top Bar */}
      <div className="relative z-20">
        <FadeIn delay={0} y={-20} as="header">
          <nav
            aria-label="Primary navigation"
            className="flex items-center justify-between gap-2 px-4 sm:px-6 md:px-10 pt-5 sm:pt-6 md:pt-8"
          >
            <a
              href="#about"
              onClick={(e) => {
                e.preventDefault();
                scrollToSection('about');
              }}
              className="text-[#D7E2EA] font-medium uppercase tracking-wider text-[10px] min-[380px]:text-xs sm:text-lg lg:text-[1.4rem] hover:opacity-70 transition-opacity duration-200 whitespace-nowrap shrink-0"
            >
              About
            </a>
            <a
              href="#skills"
              onClick={(e) => {
                e.preventDefault();
                scrollToSection('skills');
              }}
              className="text-[#D7E2EA] font-medium uppercase tracking-wider text-[10px] min-[380px]:text-xs sm:text-lg lg:text-[1.4rem] hover:opacity-70 transition-opacity duration-200 whitespace-nowrap shrink-0"
            >
              Skills
            </a>
            <a
              href="#projects"
              onClick={(e) => {
                e.preventDefault();
                scrollToSection('projects');
              }}
              className="text-[#D7E2EA] font-medium uppercase tracking-wider text-[10px] min-[380px]:text-xs sm:text-lg lg:text-[1.4rem] hover:opacity-70 transition-opacity duration-200 whitespace-nowrap shrink-0"
            >
              Projects
            </a>
            <button
              type="button"
              onClick={onOpenContact}
              className="text-[#D7E2EA] font-medium uppercase tracking-wider text-[10px] min-[380px]:text-xs sm:text-lg lg:text-[1.4rem] hover:opacity-70 transition-opacity duration-200 whitespace-nowrap shrink-0 cursor-pointer bg-transparent border-0"
            >
              Contact
            </button>
          </nav>
        </FadeIn>

        {/* Massive Hero Heading */}
        <div className="overflow-hidden mt-4 sm:mt-3 md:-mt-2 px-2 sm:px-4">
          <FadeIn delay={0.15} y={40}>
            <h1 className="hero-heading font-black uppercase tracking-tight leading-[0.9] whitespace-nowrap w-full text-center text-[10.5vw] min-[380px]:text-[11vw] sm:text-[12vw] md:text-[12.5vw] lg:text-[13vw] select-none">
              Hi, i&apos;m {PROFILE.firstName}
            </h1>
          </FadeIn>
        </div>
      </div>

      {/* Centered Hero Portrait with Magnet Effect */}
      <div className="absolute left-1/2 -translate-x-1/2 z-10 bottom-0 w-[calc(100vw-20px)] max-w-[310px] sm:max-w-[400px] md:max-w-[480px] lg:max-w-[560px] pointer-events-none sm:pointer-events-auto">
        <FadeIn delay={0.6} y={30}>
          <Magnet
            padding={150}
            strength={3}
            allowUp={false}
            activeTransition="transform 0.3s ease-out"
            inactiveTransition="transform 0.6s ease-in-out"
          >
            <div className="relative flex justify-center">
              <ResilientImage
                src={PROFILE.portraitUrl}
                alt={`${PROFILE.name} -- ${PROFILE.role}`}
                className="w-full max-h-[64vh] sm:max-h-[68vh] md:max-h-[70vh] object-contain object-bottom select-none block"
              />
              <div
                aria-hidden="true"
                className="pointer-events-none absolute inset-x-0 bottom-0 h-14 sm:h-16"
                style={{
                  background: 'linear-gradient(to top, #0C0C0C 5%, rgba(12, 12, 12, 0) 100%)',
                }}
              />
            </div>
          </Magnet>
        </FadeIn>
      </div>

      {/* Bottom Bar */}
      <div className="relative z-20 flex justify-between items-end gap-3 px-4 sm:px-6 md:px-10 pb-6 sm:pb-8 md:pb-10">
        <FadeIn delay={0.35} y={20}>
          <p
            className="text-[#D7E2EA] font-light uppercase tracking-wide leading-snug max-w-[120px] sm:max-w-[220px] md:max-w-[260px]"
            style={{ fontSize: 'clamp(0.75rem, 1.4vw, 1.5rem)' }}
          >
            {PROFILE.tagline}
          </p>
        </FadeIn>

        <FadeIn delay={0.5} y={20}>
          <ContactButton onClick={onOpenContact} />
        </FadeIn>
      </div>
    </section>
  );
}
