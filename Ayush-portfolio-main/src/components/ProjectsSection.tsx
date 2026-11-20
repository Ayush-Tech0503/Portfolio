import { useRef } from 'react';
import { motion, useScroll, useTransform, type MotionValue } from 'motion/react';
import { PROJECTS, type ProjectItem } from '../data/portfolio';
import { FadeIn } from './FadeIn';
import { LiveProjectButton } from './LiveProjectButton';
import { ResilientImage } from './ResilientImage';

interface ProjectCardProps {
  project: ProjectItem;
  index: number;
  totalCards: number;
  progress: MotionValue<number>;
  onSelectProject: (project: ProjectItem) => void;
}

function ProjectCard({
  project,
  index,
  totalCards,
  progress,
  onSelectProject,
}: ProjectCardProps) {
  const targetScale = 1 - (totalCards - 1 - index) * 0.03;
  const rangeStart = index * (1 / totalCards);
  const scale = useTransform(progress, [rangeStart, 1], [1, targetScale]);

  return (
    <div className="min-h-0 flex items-start justify-center md:min-h-[85vh] md:h-[85vh] md:sticky top-14 md:top-16 pb-5 md:pb-0">
      <motion.article
        style={{
          scale,
          top: `${index * 15}px`,
          willChange: 'transform',
        }}
        className="relative w-full max-w-6xl mx-auto rounded-[24px] sm:rounded-[50px] md:rounded-[60px] border-2 border-[#D7E2EA] bg-[#0C0C0C] p-3 min-[380px]:p-4 sm:p-6 md:p-8 origin-top"
      >
        {/* Top Row */}
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-5 sm:mb-7">
          <div className="flex items-center gap-4 sm:gap-8">
            <span
              className="font-black tabular-nums leading-none text-[#D7E2EA] shrink-0"
              style={{ fontSize: 'clamp(3rem, 10vw, 140px)' }}
            >
              {project.number}
            </span>
            <div className="flex flex-col gap-1">
              <span className="text-xs sm:text-sm uppercase tracking-widest text-[#D7E2EA]/60 font-medium">
                {project.category}
              </span>
              <h3 className="text-xl sm:text-3xl md:text-4xl font-medium uppercase text-[#D7E2EA] tracking-tight leading-tight">
                {project.name}
              </h3>
            </div>
          </div>

          <LiveProjectButton onClick={() => onSelectProject(project)} />
        </div>

        {/* Bottom Row: single-image, 2-image, or 3-image layout */}
        {project.singleImageLayout ? (
          <div className="w-full">
            <ResilientImage
              src={project.singleImageLayout}
              alt={`${project.name} website showcase`}
              loading="lazy"
              className="w-full object-cover object-top rounded-[40px] sm:rounded-[50px] md:rounded-[60px]"
              style={{ height: 'clamp(180px, 34vw, 500px)' }}
            />
          </div>
        ) : project.twoImageLayout ? (
          <div className="flex flex-col md:flex-row gap-4 sm:gap-5 items-stretch">
            <div className="w-full md:w-[64%] flex">
              <ResilientImage
                src={project.twoImageLayout[0]}
                alt={`${project.name} website showcase`}
                loading="lazy"
                className="w-full object-cover object-top rounded-[40px] sm:rounded-[50px] md:rounded-[60px]"
                style={{ height: 'clamp(180px, 32vw, 480px)' }}
              />
            </div>

            <div className="w-full md:w-[36%] flex">
              <ResilientImage
                src={project.twoImageLayout[1]}
                alt={`${project.name} social profile showcase`}
                loading="lazy"
                className="w-full object-cover object-top rounded-[40px] sm:rounded-[50px] md:rounded-[60px]"
                style={{ height: 'clamp(200px, 32vw, 480px)' }}
              />
            </div>
          </div>
        ) : (
          <div className="flex flex-col md:flex-row gap-4 sm:gap-5 items-stretch">
            <div className="w-full md:w-[40%] flex flex-col gap-4 sm:gap-5">
              <ResilientImage
                src={project.col1Images[0]}
                alt={`${project.name} showcase detail 1`}
                loading="lazy"
                className="w-full object-cover rounded-[40px] sm:rounded-[50px] md:rounded-[60px]"
                style={{ height: 'clamp(130px, 16vw, 230px)' }}
              />
              <ResilientImage
                src={project.col1Images[1]}
                alt={`${project.name} showcase detail 2`}
                loading="lazy"
                className="w-full object-cover rounded-[40px] sm:rounded-[50px] md:rounded-[60px]"
                style={{ height: 'clamp(160px, 22vw, 340px)' }}
              />
            </div>

            <div className="w-full md:w-[60%] flex">
              <ResilientImage
                src={project.col2Image}
                alt={`${project.name} primary showcase`}
                loading="lazy"
                className="w-full h-[240px] md:h-full object-cover rounded-[40px] sm:rounded-[50px] md:rounded-[60px]"
              />
            </div>
          </div>
        )}
      </motion.article>
    </div>
  );
}

interface ProjectsSectionProps {
  onSelectProject: (project: ProjectItem) => void;
}

export function ProjectsSection({ onSelectProject }: ProjectsSectionProps) {
  const containerRef = useRef<HTMLDivElement>(null);

  const { scrollYProgress } = useScroll({
    target: containerRef,
    offset: ['start start', 'end end'],
  });

  return (
    <section
      id="projects"
      className="bg-[#0C0C0C] rounded-t-[40px] sm:rounded-t-[50px] md:rounded-t-[60px] -mt-10 sm:-mt-12 md:-mt-14 relative z-10 px-5 sm:px-8 md:px-10 pt-20 sm:pt-24 md:pt-32 pb-20 sm:pb-28"
    >
      <FadeIn delay={0} y={40}>
        <h2
          className="hero-heading font-black uppercase text-center leading-none tracking-tight mb-16 sm:mb-20 md:mb-24"
          style={{ fontSize: 'clamp(3rem, 12vw, 160px)' }}
        >
          Project
        </h2>
      </FadeIn>

      <div ref={containerRef} className="relative">
        {PROJECTS.map((project, index) => (
          <ProjectCard
            key={project.number}
            project={project}
            index={index}
            totalCards={PROJECTS.length}
            progress={scrollYProgress}
            onSelectProject={onSelectProject}
          />
        ))}
      </div>
    </section>
  );
}
