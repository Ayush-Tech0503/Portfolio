import { useEffect, useRef, useState } from 'react';
import { MARQUEE_IMAGES } from '../data/portfolio';
import { ResilientImage } from './ResilientImage';

const row1Unit = [...MARQUEE_IMAGES, ...MARQUEE_IMAGES];
const row2Unit = [...[...MARQUEE_IMAGES].reverse(), ...[...MARQUEE_IMAGES].reverse()];

const row1Tripled = [...row1Unit, ...row1Unit, ...row1Unit];
const row2Tripled = [...row2Unit, ...row2Unit, ...row2Unit];

export function MarqueeSection() {
  const sectionRef = useRef<HTMLElement>(null);
  const [offset, setOffset] = useState(0);

  useEffect(() => {
    let rafId: number | null = null;

    const updateOffset = () => {
      const el = sectionRef.current;
      if (!el) return;
      const sectionTop = el.offsetTop;
      const nextOffset = (window.scrollY - sectionTop + window.innerHeight) * 0.3;
      setOffset(nextOffset);
    };

    const handleScroll = () => {
      if (rafId !== null) return;
      rafId = window.requestAnimationFrame(() => {
        updateOffset();
        rafId = null;
      });
    };

    updateOffset();
    window.addEventListener('scroll', handleScroll, { passive: true });
    window.addEventListener('resize', updateOffset, { passive: true });

    return () => {
      window.removeEventListener('scroll', handleScroll);
      window.removeEventListener('resize', updateOffset);
      if (rafId !== null) {
        window.cancelAnimationFrame(rafId);
      }
    };
  }, []);

  return (
    <section
      ref={sectionRef}
      aria-label="Website and Project Showcase"
      className="bg-[#0C0C0C] pt-24 sm:pt-32 md:pt-40 pb-10 overflow-hidden"
    >
      <div className="flex flex-col gap-3">
        {/* Row 1: Moves RIGHT on scroll */}
        <div
          className="flex gap-3 w-max"
          style={{
            transform: `translate3d(calc(-33.333% + ${offset - 200}px), 0, 0)`,
            willChange: 'transform',
          }}
        >
          {row1Tripled.map((item, idx) => (
            <div
              key={`row1-${idx}`}
              className="w-[280px] h-[180px] sm:w-[360px] sm:h-[230px] md:w-[420px] md:h-[270px] shrink-0 rounded-2xl overflow-hidden bg-[#141416]"
            >
              <ResilientImage
                src={item.src}
                alt={item.alt}
                loading="lazy"
                className="w-full h-full rounded-2xl object-cover object-top block"
              />
            </div>
          ))}
        </div>

        {/* Row 2: Moves LEFT on scroll */}
        <div
          className="flex gap-3 w-max"
          style={{
            transform: `translate3d(calc(-33.333% - ${offset - 200}px), 0, 0)`,
            willChange: 'transform',
          }}
        >
          {row2Tripled.map((item, idx) => (
            <div
              key={`row2-${idx}`}
              className="w-[280px] h-[180px] sm:w-[360px] sm:h-[230px] md:w-[420px] md:h-[270px] shrink-0 rounded-2xl overflow-hidden bg-[#141416]"
            >
              <ResilientImage
                src={item.src}
                alt={item.alt}
                loading="lazy"
                className="w-full h-full rounded-2xl object-cover object-top block"
              />
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
