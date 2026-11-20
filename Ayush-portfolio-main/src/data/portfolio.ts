export const PROFILE = {
  name: 'Ayush Rathore',
  firstName: 'ayush',
  role: 'Digital Marketing Executive',
  tagline: 'a digital marketing executive building sites that rank, load fast, and convert',
  location: 'Indore, Madhya Pradesh, India',
  primaryEmail: 'ayushrathore.dm@gmail.com',
  linkedinUrl: 'https://www.linkedin.com/in/ayush-rathoree/',
  linkedinHandle: 'linkedin.com/in/ayush-rathoree',
  instagramUrl: 'https://www.instagram.com/ayushrathore.in',
  substackUrl: 'https://substack.com/@ayushrathore05',
  portraitUrl: '/assets/aistudio/ayush.web_c0e32742.png',
  aboutBio:
    "With a background in B.Com and Digital Marketing, i focus on SEO, WordPress, performance ads, and AI workflows. As a Digital Marketing Executive at Codiotic Technologies, i help businesses stand out and grow through sites that rank, load fast, and convert. Let's build something impactful together!",
};

export const ABOUT_3D_ASSETS = {
  topLeft:
    'https://shrug-person-78902957.figma.site/_components/v2/ebb2b8f25d8e24d5f0a5ca8af4c950de81aa2fd7/moon_icon.11395d36.png',
  bottomLeft:
    'https://shrug-person-78902957.figma.site/_components/v2/ebb2b8f25d8e24d5f0a5ca8af4c950de81aa2fd7/p59_1.4659672e.png',
  topRight:
    'https://shrug-person-78902957.figma.site/_components/v2/ebb2b8f25d8e24d5f0a5ca8af4c950de81aa2fd7/lego_icon-1.703bb594.png',
  bottomRight:
    'https://shrug-person-78902957.figma.site/_components/v2/ebb2b8f25d8e24d5f0a5ca8af4c950de81aa2fd7/Group_134-1.2e04f3ce.png',
};

export const MARQUEE_IMAGES = [
  {
    src: '/assets/aistudio/architect-web_c1d741c9.png',
    alt: 'Architect Luxury Design Website',
  },
  {
    src: '/assets/aistudio/Codiotic-web_378471df.png',
    alt: 'Codiotic AI Software Development Website',
  },
  {
    src: '/assets/aistudio/20Clicks-web_3acdc6ec.png',
    alt: '20Clicks Digital Marketing Agency Website',
  },
  {
    src: '/assets/aistudio/Sars_b475529b.png',
    alt: 'Shree Abhay Raksha Services Website',
  },
  {
    src: '/assets/aistudio/SMT-web_43b14d49.png',
    alt: 'Show Me There Outdoor Advertising Platform',
  },
];

export interface ServiceItem {
  number: string;
  name: string;
  description: string;
}

export const SERVICES: ServiceItem[] = [
  {
    number: '01',
    name: 'SEO Strategy',
    description:
      'Technical SEO, local search optimization, and keyword research tailored to help businesses rank higher and attract qualified organic traffic.',
  },
  {
    number: '02',
    name: 'WordPress Dev',
    description:
      'Custom WordPress and Elementor websites built for speed, Core Web Vitals performance, and clean conversion-focused user experiences.',
  },
  {
    number: '03',
    name: 'Paid Media',
    description:
      'Data-driven Google Ads, Meta Ads, and LinkedIn Advertising campaigns engineered for lead generation and measurable business ROI.',
  },
  {
    number: '04',
    name: 'AI & Content',
    description:
      'Landing page copywriting, content strategy, and AI-powered creative workflows that sharpen brand messaging and campaign velocity.',
  },
  {
    number: '05',
    name: 'Analytics & Ops',
    description:
      'Google Analytics, Search Console, Tag Manager tracking, and cross-functional product operations to turn campaign data into growth.',
  },
];

export interface ProjectItem {
  number: string;
  name: string;
  category: string;
  summary: string;
  deliverables: string;
  year: string;
  liveUrl?: string;
  singleImageLayout?: string;
  twoImageLayout?: [string, string];
  col1Images: [string, string];
  col2Image: string;
}

export const PROJECTS: ProjectItem[] = [
  {
    number: '01',
    name: 'Show Me There',
    category: 'Product Ops · Codiotic',
    summary:
      "Digital growth and product operations for India's first verified outdoor advertising platform -- spanning website planning, information architecture, SEO strategy, brand messaging, and AI creative workflows.",
    deliverables: 'Website Planning · SEO Strategy · Brand Messaging · AI Creative Concepts',
    year: '2026',
    liveUrl: 'https://showmethere.com/',
    twoImageLayout: [
      '/assets/aistudio/SMT-web_43b14d49.png',
      '/assets/aistudio/image_60958de2.png',
    ],
    col1Images: [
      '/assets/aistudio/SMT-web_43b14d49.png',
      '/assets/aistudio/image_60958de2.png',
    ],
    col2Image: '/assets/aistudio/SMT-web_43b14d49.png',
  },
  {
    number: '02',
    name: '20Clicks',
    category: 'Digital Marketing Agency',
    summary:
      'Company website & landing pages built for a Digital Marketing Agency, powered by Technical SEO and comprehensive website optimization to maximize speed, search visibility, and lead conversion.',
    deliverables: 'Company website & landing pages · Technical SEO · Website optimization',
    year: '2025',
    liveUrl: 'https://20clicks.com/',
    twoImageLayout: [
      '/assets/aistudio/20Clicks-web_3acdc6ec.png',
      '/assets/aistudio/image_df327180.png',
    ],
    col1Images: [
      '/assets/aistudio/20Clicks-web_3acdc6ec.png',
      '/assets/aistudio/image_df327180.png',
    ],
    col2Image: '/assets/aistudio/20Clicks-web_3acdc6ec.png',
  },
  {
    number: '03',
    name: 'NITCON',
    category: 'Union Government Company',
    summary:
      'Led a digital brand-building and marketing campaign for NITCON Limited, a Union Government Company, strengthening its corporate presence and institutional credibility across multiple digital platforms. Developed a Trust → Authority → Conversion content strategy, managed LinkedIn Awareness Ads, and coordinated project-focused communication for the National Industrial Township – Siliguri–Jalpaiguri. The campaign focused on increasing brand visibility, communicating organisational capabilities, and building awareness among relevant stakeholders.',
    deliverables:
      'Trust → Authority → Conversion Strategy · LinkedIn Awareness Ads · Corporate Communications',
    year: '2026',
    singleImageLayout: '/assets/aistudio/image_e39eaa9b.png',
    col1Images: ['/assets/aistudio/image_e39eaa9b.png', '/assets/aistudio/image_e39eaa9b.png'],
    col2Image: '/assets/aistudio/image_e39eaa9b.png',
  },
  {
    number: '04',
    name: 'CareerPrefix',
    category: 'EdTech · Meta & Google Ads',
    summary:
      "Managed Meta Ads and Google Ads for CareerPrefix, an online learning platform offering professional commerce courses for CA, CS, CMA, CFA and ACCA aspirants. Focused on planning and executing paid advertising campaigns to promote courses, reach relevant student audiences, generate enquiries and drive course purchases. Worked on campaign targeting, audience research, ad creatives, keyword strategy and performance optimisation to strengthen the brand's digital presence and support student acquisition.",
    deliverables:
      'Meta Ads & Google Ads · Audience Research · Keyword Strategy · Performance Optimisation',
    year: '2026',
    liveUrl: 'https://www.careerprefix.com/',
    singleImageLayout: '/assets/aistudio/image_58edffca.png',
    col1Images: ['/assets/aistudio/image_58edffca.png', '/assets/aistudio/image_58edffca.png'],
    col2Image: '/assets/aistudio/image_58edffca.png',
  },
];

export interface CertificationItem {
  number: string;
  title: string;
  issuer: string;
}

export const CERTIFICATIONS: CertificationItem[] = [
  {
    number: '01',
    title: 'Social Media Marketing',
    issuer: 'HubSpot',
  },
  {
    number: '02',
    title: 'Inbound Marketing',
    issuer: 'HubSpot',
  },
  {
    number: '03',
    title: 'SEO Strategy',
    issuer: 'Semrush Academy',
  },
  {
    number: '04',
    title: 'Become an AI Powered Marketer',
    issuer: 'Semrush Academy',
  },
];
