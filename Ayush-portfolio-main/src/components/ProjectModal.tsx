import { useEffect } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { X, ArrowUpRight } from 'lucide-react';
import type { ProjectItem } from '../data/portfolio';
import { ResilientImage } from './ResilientImage';

interface ProjectModalProps {
  project: ProjectItem | null;
  onClose: () => void;
}

export function ProjectModal({ project, onClose }: ProjectModalProps) {
  useEffect(() => {
    if (!project) return;
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        onClose();
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [project, onClose]);

  return (
    <AnimatePresence>
      {project && (
        <motion.div
          role="dialog"
          aria-modal="true"
          aria-labelledby="project-modal-title"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.2 }}
          onClick={onClose}
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/85 backdrop-blur-sm p-4 sm:p-6"
        >
          <motion.div
            initial={{ opacity: 0, y: 20, scale: 0.98 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 12, scale: 0.98 }}
            transition={{ duration: 0.25, ease: [0.16, 1, 0.3, 1] }}
            onClick={(e) => e.stopPropagation()}
            className="w-full max-w-3xl rounded-[32px] sm:rounded-[40px] border-2 border-[#D7E2EA]/80 bg-[#0C0C0C] text-[#D7E2EA] p-5 sm:p-8 max-h-[92vh] overflow-y-auto"
          >
            <div className="flex items-start justify-between gap-4 mb-5">
              <div>
                <div className="flex items-center gap-2 text-xs uppercase tracking-widest text-[#D7E2EA]/60 font-medium mb-1">
                  <span className="tabular-nums">{project.number}</span>
                  <span aria-hidden="true">·</span>
                  <span>{project.category}</span>
                  <span aria-hidden="true">·</span>
                  <span className="tabular-nums">{project.year}</span>
                </div>
                <h2
                  id="project-modal-title"
                  className="text-2xl sm:text-4xl font-black uppercase tracking-tight text-[#D7E2EA]"
                >
                  {project.name}
                </h2>
              </div>

              <button
                type="button"
                onClick={onClose}
                aria-label="Close project preview"
                className="w-10 h-10 rounded-full border border-[#D7E2EA]/30 flex items-center justify-center text-[#D7E2EA] hover:bg-[#D7E2EA]/10 transition-colors cursor-pointer shrink-0"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            {/* Single Project Image */}
            <div className="rounded-[24px] sm:rounded-[32px] overflow-hidden bg-[#141416] mb-6">
              <ResilientImage
                src={project.col2Image}
                alt={`${project.name} preview`}
                className="w-full h-[240px] sm:h-[400px] object-cover object-top block"
              />
            </div>

            {/* Project Description & Link */}
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-5 pt-4 border-t border-[#D7E2EA]/15">
              <div className="max-w-xl">
                <p className="text-xs uppercase tracking-wider text-[#D7E2EA]/55 mb-1.5">
                  {project.deliverables}
                </p>
                <p className="text-sm sm:text-base font-light text-[#D7E2EA]/85 leading-relaxed">
                  {project.summary}
                </p>
              </div>

              {project.liveUrl && (
                <a
                  href={project.liveUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center justify-center gap-2 rounded-full border-2 border-[#D7E2EA] text-[#D7E2EA] font-medium uppercase tracking-widest px-6 py-3 text-xs sm:text-sm whitespace-nowrap shrink-0 hover:bg-[#D7E2EA]/10 transition-colors"
                >
                  <span>Visit Site</span>
                  <ArrowUpRight className="w-4 h-4" aria-hidden="true" />
                </a>
              )}
            </div>
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
