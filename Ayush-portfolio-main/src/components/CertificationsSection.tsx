import { Award } from 'lucide-react';
import { CERTIFICATIONS } from '../data/portfolio';
import { FadeIn } from './FadeIn';

export function CertificationsSection() {
  return (
    <section
      id="certifications"
      className="bg-[#0C0C0C] px-5 sm:px-8 md:px-10 pt-10 sm:pt-14 pb-24 sm:pb-32 relative z-10"
    >
      <div className="max-w-6xl mx-auto">
        <FadeIn delay={0} y={35}>
          <p className="text-xs sm:text-sm uppercase tracking-widest text-[#D7E2EA]/60 font-medium text-center mb-3">
            Achievements Unlocked
          </p>
          <h2
            className="hero-heading font-black uppercase text-center leading-none tracking-tight mb-14 sm:mb-16 md:mb-20"
            style={{ fontSize: 'clamp(2.5rem, 9.5vw, 130px)' }}
          >
            Certifications
          </h2>
        </FadeIn>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5 sm:gap-6">
          {CERTIFICATIONS.map((cert, i) => (
            <FadeIn key={cert.number} delay={i * 0.08} y={24}>
              <article className="h-full rounded-[32px] border-2 border-[#D7E2EA]/30 bg-[#0C0C0C] p-6 sm:p-7 flex flex-col justify-between gap-8 transition-colors duration-200 hover:border-[#D7E2EA]">
                <div className="flex items-center justify-between gap-3">
                  <span className="text-2xl sm:text-3xl font-black tabular-nums leading-none text-[#D7E2EA]/85">
                    {cert.number}
                  </span>
                  <Award className="w-5 h-5 text-[#BBCCD7]/75 shrink-0" aria-hidden="true" />
                </div>

                <div>
                  <h3 className="text-lg sm:text-xl font-medium uppercase tracking-tight text-[#D7E2EA] leading-snug">
                    {cert.title}
                  </h3>
                  <p className="text-xs sm:text-sm uppercase tracking-widest text-[#D7E2EA]/60 font-light mt-2">
                    {cert.issuer}
                  </p>
                </div>
              </article>
            </FadeIn>
          ))}
        </div>
      </div>
    </section>
  );
}
