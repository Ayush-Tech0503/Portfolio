import type { ReactNode } from 'react';
import { motion } from 'motion/react';

type SupportedElement = 'div' | 'section' | 'header' | 'nav' | 'h1' | 'h2' | 'h3' | 'p' | 'span' | 'article';

const motionElements = {
  div: motion.create('div'),
  section: motion.create('section'),
  header: motion.create('header'),
  nav: motion.create('nav'),
  h1: motion.create('h1'),
  h2: motion.create('h2'),
  h3: motion.create('h3'),
  p: motion.create('p'),
  span: motion.create('span'),
  article: motion.create('article'),
};

interface FadeInProps {
  children: ReactNode;
  delay?: number;
  duration?: number;
  x?: number;
  y?: number;
  className?: string;
  as?: SupportedElement;
}

export function FadeIn({
  children,
  delay = 0,
  duration = 0.7,
  x = 0,
  y = 30,
  className = '',
  as = 'div',
}: FadeInProps) {
  const MotionComponent = motionElements[as] as typeof motion.div;

  return (
    <MotionComponent
      initial={{ opacity: 0, x, y }}
      whileInView={{ opacity: 1, x: 0, y: 0 }}
      viewport={{ once: true, margin: '50px', amount: 0 }}
      transition={{
        duration,
        delay,
        ease: [0.25, 0.1, 0.25, 1],
      }}
      className={className}
    >
      {children}
    </MotionComponent>
  );
}
