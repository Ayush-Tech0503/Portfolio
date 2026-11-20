import { useRef, type CSSProperties } from 'react';
import { motion, useScroll, useTransform, type MotionValue } from 'motion/react';

interface AnimatedCharProps {
  char: string;
  progress: MotionValue<number>;
  range: [number, number];
}

function AnimatedChar({ char, progress, range }: AnimatedCharProps) {
  const opacity = useTransform(progress, range, [0.2, 1]);

  return (
    <span className="relative inline-block">
      <span className="opacity-0" aria-hidden="true">
        {char}
      </span>
      <motion.span style={{ opacity }} className="absolute left-0 top-0">
        {char}
      </motion.span>
    </span>
  );
}

interface AnimatedTextProps {
  text: string;
  className?: string;
  style?: CSSProperties;
}

export function AnimatedText({ text, className = '', style }: AnimatedTextProps) {
  const containerRef = useRef<HTMLParagraphElement>(null);

  const { scrollYProgress } = useScroll({
    target: containerRef,
    offset: ['start 0.8', 'end 0.2'],
  });

  const words = text.split(' ');
  const totalChars = text.length;
  let globalIndex = 0;

  return (
    <p ref={containerRef} className={className} style={style}>
      {words.map((word, wordIdx) => {
        const wordStart = globalIndex;
        const chars = word.split('');
        globalIndex += chars.length;

        const hasSpace = wordIdx < words.length - 1;
        if (hasSpace) {
          globalIndex += 1;
        }

        return (
          <span key={`word-${wordIdx}`}>
            <span className="inline-block whitespace-nowrap">
              {chars.map((char, charIdx) => {
                const index = wordStart + charIdx;
                const start = index / totalChars;
                const end = (index + 1) / totalChars;
                return (
                  <AnimatedChar
                    key={`char-${index}`}
                    char={char}
                    progress={scrollYProgress}
                    range={[start, end]}
                  />
                );
              })}
            </span>
            {hasSpace ? ' ' : null}
          </span>
        );
      })}
    </p>
  );
}
