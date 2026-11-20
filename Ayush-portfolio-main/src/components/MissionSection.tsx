import { FadeIn } from './FadeIn';
import { ContactButton } from './ContactButton';
import { SocialLinks } from './SocialLinks';

interface MissionSectionProps {
  onOpenContact: () => void;
}

export function MissionSection({ onOpenContact }: MissionSectionProps) {
  return (
    <section
      id="mission"
      className="bg-[#0C0C0C] px-5 sm:px-8 md:px-10 pt-10 sm:pt-14 pb-24 sm:pb-32 relative z-10"
    >
      <div className="max-w-5xl mx-auto">
        <FadeIn delay={0} y={35}>
          <h2
            className="hero-heading font-black uppercase text-center leading-none tracking-tight mb-12 sm:mb-16"
            style={{ fontSize: 'clamp(2.5rem, 10vw, 130px)' }}
          >
            Mission
          </h2>
        </FadeIn>

        <FadeIn delay={0.1} y={24}>
          <div className="rounded-[32px] sm:rounded-[50px] md:rounded-[60px] border-2 border-[#D7E2EA]/30 bg-[#0C0C0C] p-5 sm:p-12 md:p-16 flex flex-col items-center text-center gap-8">
            <p
              className="text-[#D7E2EA] font-medium leading-relaxed max-w-3xl"
              style={{ fontSize: 'clamp(1.1rem, 2.2vw, 1.65rem)' }}
            >
              Help businesses build a strong digital presence through strategic marketing, SEO, and
              modern web development; every website should look professional and deliver measurable
              results.
            </p>

            <div className="w-16 h-px bg-[#D7E2EA]/25" aria-hidden="true" />

            <p
              className="text-[#D7E2EA]/70 font-light leading-relaxed max-w-2xl"
              style={{ fontSize: 'clamp(0.95rem, 1.6vw, 1.2rem)' }}
            >
              Career objective: combine SEO, WordPress development, AI, and performance marketing to
              build digital solutions with real business impact, and keep leveling up alongside the
              tech.
            </p>

            <div className="pt-2 flex flex-col items-center gap-6">
              <ContactButton onClick={onOpenContact} />
              <SocialLinks />
            </div>
          </div>
        </FadeIn>
      </div>
    </section>
  );
}
