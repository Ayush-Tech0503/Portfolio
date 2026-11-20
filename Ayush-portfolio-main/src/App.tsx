import { useState } from 'react';
import { HeroSection } from './components/HeroSection';
import { MarqueeSection } from './components/MarqueeSection';
import { AboutSection } from './components/AboutSection';
import { ServicesSection } from './components/ServicesSection';
import { ProjectsSection } from './components/ProjectsSection';
import { CertificationsSection } from './components/CertificationsSection';
import { MissionSection } from './components/MissionSection';
import { ContactModal } from './components/ContactModal';
import { ProjectModal } from './components/ProjectModal';
import type { ProjectItem } from './data/portfolio';

export default function App() {
  const [contactOpen, setContactOpen] = useState(false);
  const [selectedProject, setSelectedProject] = useState<ProjectItem | null>(null);

  return (
    <main
      className="min-h-screen bg-[#0C0C0C] text-[#D7E2EA]"
      style={{ backgroundColor: '#0C0C0C', overflowX: 'clip' }}
    >
      <HeroSection onOpenContact={() => setContactOpen(true)} />
      <MarqueeSection />
      <AboutSection onOpenContact={() => setContactOpen(true)} />
      <ServicesSection />
      <ProjectsSection onSelectProject={(project) => setSelectedProject(project)} />
      <CertificationsSection />
      <MissionSection onOpenContact={() => setContactOpen(true)} />

      <ContactModal isOpen={contactOpen} onClose={() => setContactOpen(false)} />
      <ProjectModal
        project={selectedProject}
        onClose={() => setSelectedProject(null)}
      />
    </main>
  );
}
