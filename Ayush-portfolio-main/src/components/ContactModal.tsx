import { useEffect, useState, type FormEvent } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { X, Check, Copy, Send } from 'lucide-react';
import { PROFILE, SERVICES } from '../data/portfolio';
import { SocialLinks } from './SocialLinks';

interface ContactModalProps {
  isOpen: boolean;
  onClose: () => void;
}

export function ContactModal({ isOpen, onClose }: ContactModalProps) {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [service, setService] = useState(SERVICES[0].name);
  const [message, setMessage] = useState('');
  const [submitted, setSubmitted] = useState(false);
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    if (!isOpen) return;
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        onClose();
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [isOpen, onClose]);

  const handleCopyEmail = async () => {
    try {
      await navigator.clipboard.writeText(PROFILE.primaryEmail);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      setCopied(false);
    }
  };

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
    if (!name.trim() || !email.trim() || !message.trim()) return;
    setSubmitted(true);
  };

  const handleReset = () => {
    setName('');
    setEmail('');
    setService(SERVICES[0].name);
    setMessage('');
    setSubmitted(false);
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div
          role="dialog"
          aria-modal="true"
          aria-labelledby="contact-modal-title"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.2 }}
          onClick={onClose}
          className="fixed inset-0 z-50 flex items-start sm:items-center justify-center bg-black/80 backdrop-blur-sm p-3 sm:p-6 overflow-y-auto"
        >
          <motion.div
            initial={{ opacity: 0, y: 20, scale: 0.98 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 12, scale: 0.98 }}
            transition={{ duration: 0.25, ease: [0.16, 1, 0.3, 1] }}
            onClick={(e) => e.stopPropagation()}
            className="w-full max-w-xl rounded-[20px] sm:rounded-[32px] border-2 border-[#D7E2EA]/80 bg-[#0C0C0C] text-[#D7E2EA] p-3 min-[380px]:p-4 sm:p-8 relative my-auto max-h-[94svh] overflow-y-auto"
          >
            <div className="flex items-start justify-between gap-4 mb-6">
              <div>
                <p className="text-xs uppercase tracking-widest text-[#D7E2EA]/60 font-medium mb-1">
                  {PROFILE.name} · {PROFILE.role}
                </p>
                <h2
                  id="contact-modal-title"
                  className="text-2xl sm:text-3xl font-black uppercase tracking-tight text-[#D7E2EA]"
                >
                  Let&apos;s Collaborate
                </h2>
              </div>

              <button
                type="button"
                onClick={onClose}
                aria-label="Close contact dialog"
                className="w-10 h-10 rounded-full border border-[#D7E2EA]/30 flex items-center justify-center text-[#D7E2EA] hover:bg-[#D7E2EA]/10 transition-colors cursor-pointer shrink-0"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            {submitted ? (
              <div className="py-8 flex flex-col items-center text-center gap-4">
                <div className="w-12 h-12 rounded-full border border-[#D7E2EA]/40 flex items-center justify-center text-[#D7E2EA]">
                  <Check className="w-6 h-6" />
                </div>
                <h3 className="text-xl font-medium uppercase tracking-wide text-[#D7E2EA]">
                  Inquiry Ready
                </h3>
                <p className="text-sm sm:text-base font-light text-[#D7E2EA]/75 max-w-md leading-relaxed">
                  Thanks, {name}. Your campaign brief for {service} has been prepared for{' '}
                  {PROFILE.name}. You can also reach him directly at {PROFILE.primaryEmail}.
                </p>
                <div className="flex items-center gap-3 mt-2">
                  <button
                    type="button"
                    onClick={handleReset}
                    className="rounded-full border border-[#D7E2EA]/40 px-6 py-2.5 text-xs uppercase tracking-widest text-[#D7E2EA] hover:bg-[#D7E2EA]/10 transition-colors cursor-pointer"
                  >
                    Send Another
                  </button>
                  <button
                    type="button"
                    onClick={onClose}
                    className="rounded-full bg-[#D7E2EA] text-[#0C0C0C] px-6 py-2.5 text-xs font-medium uppercase tracking-widest hover:opacity-90 transition-opacity cursor-pointer"
                  >
                    Done
                  </button>
                </div>
              </div>
            ) : (
              <form onSubmit={handleSubmit} className="flex flex-col gap-4">
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <label className="flex flex-col gap-1.5">
                    <span className="text-xs uppercase tracking-wider text-[#D7E2EA]/70 font-medium">
                      Name
                    </span>
                    <input
                      type="text"
                      required
                      value={name}
                      onChange={(e) => setName(e.target.value)}
                      placeholder="Your name"
                      className="w-full rounded-xl border border-[#D7E2EA]/25 bg-white/[0.03] px-4 py-2.5 text-sm text-[#D7E2EA] placeholder:text-[#D7E2EA]/30 focus:outline-none focus:border-[#D7E2EA]"
                    />
                  </label>

                  <label className="flex flex-col gap-1.5">
                    <span className="text-xs uppercase tracking-wider text-[#D7E2EA]/70 font-medium">
                      Email
                    </span>
                    <input
                      type="email"
                      required
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      placeholder="you@company.com"
                      className="w-full rounded-xl border border-[#D7E2EA]/25 bg-white/[0.03] px-4 py-2.5 text-sm text-[#D7E2EA] placeholder:text-[#D7E2EA]/30 focus:outline-none focus:border-[#D7E2EA]"
                    />
                  </label>
                </div>

                <label className="flex flex-col gap-1.5">
                  <span className="text-xs uppercase tracking-wider text-[#D7E2EA]/70 font-medium">
                    Skill Focus
                  </span>
                  <select
                    value={service}
                    onChange={(e) => setService(e.target.value)}
                    className="w-full rounded-xl border border-[#D7E2EA]/25 bg-[#141416] px-4 py-2.5 text-sm text-[#D7E2EA] focus:outline-none focus:border-[#D7E2EA]"
                  >
                    {SERVICES.map((item) => (
                      <option key={item.number} value={item.name}>
                        {item.number} — {item.name}
                      </option>
                    ))}
                  </select>
                </label>

                <label className="flex flex-col gap-1.5">
                  <span className="text-xs uppercase tracking-wider text-[#D7E2EA]/70 font-medium">
                    Campaign Brief
                  </span>
                  <textarea
                    rows={3}
                    required
                    value={message}
                    onChange={(e) => setMessage(e.target.value)}
                    placeholder="Share your brand goals, target channels, and timeline..."
                    className="w-full rounded-xl border border-[#D7E2EA]/25 bg-white/[0.03] px-4 py-2.5 text-sm text-[#D7E2EA] placeholder:text-[#D7E2EA]/30 focus:outline-none focus:border-[#D7E2EA] resize-none"
                  />
                </label>

                <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pt-3 border-t border-[#D7E2EA]/15 mt-2">
                  <div className="flex flex-col gap-2.5">
                    <button
                      type="button"
                      onClick={handleCopyEmail}
                      className="inline-flex items-center gap-2 text-xs text-[#D7E2EA]/80 hover:text-[#D7E2EA] transition-colors cursor-pointer"
                    >
                      {copied ? (
                        <Check className="w-4 h-4 shrink-0" />
                      ) : (
                        <Copy className="w-4 h-4 shrink-0" />
                      )}
                      <span>{copied ? 'Copied to clipboard' : PROFILE.primaryEmail}</span>
                    </button>
                    <SocialLinks size="sm" />
                  </div>

                  <button
                    type="submit"
                    className="inline-flex items-center justify-center gap-2 rounded-full px-7 py-3 text-xs font-medium uppercase tracking-widest text-white cursor-pointer transition-transform duration-200 hover:scale-[1.02] active:scale-[0.98] whitespace-nowrap shrink-0"
                    style={{
                      background:
                        'linear-gradient(123deg, #18011F 7%, #B600A8 37%, #7621B0 72%, #BE4C00 100%)',
                      boxShadow: '0px 4px 4px rgba(181, 1, 167, 0.25), 4px 4px 12px #7721B1 inset',
                      outline: '2px solid #FFFFFF',
                      outlineOffset: '-3px',
                    }}
                  >
                    <Send className="w-3.5 h-3.5" />
                    <span>Send Inquiry</span>
                  </button>
                </div>
              </form>
            )}
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
