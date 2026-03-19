import React, { useEffect, useState, useRef, useCallback } from 'react';
import { motion, useMotionValue, useSpring } from 'framer-motion';
import { Helmet } from 'react-helmet-async';
import { 
  Clock, 
  DeviceMobile, 
  VideoCamera, 
  CurrencyInr, 
  Globe, 
  Robot, 
  TrendUp, 
  PenNib, 
  Video, 
  Briefcase, 
  Buildings, 
  ChartBar, 
  Lightning, 
  Target, 
  ChatCircleDots, 
  Envelope, 
  InstagramLogo,
  ArrowRight,
  List,
  X,
  CheckCircle,
  WarningCircle
} from '@phosphor-icons/react';
import { submitContactForm } from '../services/firebaseService';
import WhatsAppFloat from '../components/WhatsAppFloat';
import ThemeToggle from '../components/ThemeToggle';
import MorphingSubmitButton from '../components/MorphingSubmitButton';
import logoImg from '../assets/logo.jpg';
import { siteContent } from '../content/siteContent';
import './home-reference.css';

const canHover = typeof window !== 'undefined' && window.matchMedia('(hover: hover)').matches;

const InteractiveCard = ({ id, children, style, className, delay = 0 }) => {
  const cardRef = useRef(null);
  const [isVisible, setIsVisible] = useState(false);

  const mouseX = useMotionValue(0);
  const mouseY = useMotionValue(0);
  const glowX = useSpring(mouseX, { stiffness: 150, damping: 25 });
  const glowY = useSpring(mouseY, { stiffness: 150, damping: 25 });

  useEffect(() => {
    const el = cardRef.current;
    if (!el) return;
    const obs = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setTimeout(() => setIsVisible(true), delay);
          obs.disconnect();
        }
      },
      { threshold: 0.2 }
    );
    obs.observe(el);
    return () => obs.disconnect();
  }, [delay]);

  const handleMouseMove = useCallback((e) => {
    if (!canHover) return;
    const rect = e.currentTarget.getBoundingClientRect();
    mouseX.set(e.clientX - rect.left);
    mouseY.set(e.clientY - rect.top);
  }, [mouseX, mouseY]);

  return (
    <motion.div
      ref={cardRef}
      id={id}
      className={`p-card glass-card ${className || ''} ${isVisible ? 'visible' : ''}`}
      style={{
        ...style,
        opacity: isVisible ? 1 : 0,
        scale: isVisible ? 1 : 0.98,
        y: isVisible ? 0 : 20,
      }}
      initial={false}
      animate={{
        opacity: isVisible ? 1 : 0,
        scale: isVisible ? 1 : 0.98,
        y: isVisible ? 0 : 20,
      }}
      transition={{ duration: 0.6, ease: [0.22, 1, 0.36, 1] }}
      onMouseMove={handleMouseMove}
      whileHover={{ y: -5, scale: 1.01 }}
    >
      <motion.div
        className="card-glow-follow"
        style={{
          left: glowX,
          top: glowY,
        }}
      />
      {children}
    </motion.div>
  );
};

const Home = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone: '',
    company: '',
    service: '',
    message: ''
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitStatus, setSubmitStatus] = useState('idle');
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  useEffect(() => {
    if (submitStatus !== 'success') return;
    const timer = window.setTimeout(() => setSubmitStatus('idle'), 5000);
    return () => window.clearTimeout(timer);
  }, [submitStatus]);

  useEffect(() => {
    const cursor = document.getElementById('cursor');
    const cursorRing = document.getElementById('cursorRing');
    let mouseX = 0, mouseY = 0, ringX = 0, ringY = 0, rafId;

    const onMouseMove = (event) => {
      mouseX = event.clientX;
      mouseY = event.clientY;
      if (cursor) {
        cursor.style.left = `${mouseX}px`;
        cursor.style.top = `${mouseY}px`;
      }
    };

    const animateCursor = () => {
      ringX += (mouseX - ringX) * 0.12;
      ringY += (mouseY - ringY) * 0.12;
      if (cursorRing) {
        cursorRing.style.left = `${ringX}px`;
        cursorRing.style.top = `${ringY}px`;
      }
      rafId = window.requestAnimationFrame(animateCursor);
    };

    document.addEventListener('mousemove', onMouseMove);
    animateCursor();

    const hoverTargets = Array.from(document.querySelectorAll('a, button, .service-item, .price-card, .who-card, .step-card'));
    const onEnter = () => { if (cursor) cursor.classList.add('hover'); if (cursorRing) cursorRing.classList.add('hover'); };
    const onLeave = () => { if (cursor) cursor.classList.remove('hover'); if (cursorRing) cursorRing.classList.remove('hover'); };

    hoverTargets.forEach(el => { el.addEventListener('mouseenter', onEnter); el.addEventListener('mouseleave', onLeave); });

    const navbar = document.getElementById('navbar');
    const onScroll = () => {
      if (!navbar) return;
      if (window.scrollY > 60) navbar.classList.add('scrolled');
      else navbar.classList.remove('scrolled');
    };

    window.addEventListener('scroll', onScroll);
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => { if (entry.isIntersecting) entry.target.classList.add('visible'); });
    }, { threshold: 0.15 });

    document.querySelectorAll('.reveal, .reveal-left, .step-card, .service-item, .price-card, .who-card').forEach(el => observer.observe(el));

    return () => {
      document.removeEventListener('mousemove', onMouseMove);
      window.removeEventListener('scroll', onScroll);
      window.cancelAnimationFrame(rafId);
      hoverTargets.forEach(el => { el.removeEventListener('mouseenter', onEnter); el.removeEventListener('mouseleave', onLeave); });
      observer.disconnect();
    };
  }, []);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
    if (submitStatus === 'error') setSubmitStatus('idle');
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (isSubmitting || submitStatus === 'success') return;
    if (!formData.name.trim() || !formData.email.trim() || !formData.message.trim()) { setSubmitStatus('error'); return; }

    try {
      setIsSubmitting(true);
      setSubmitStatus('submitting');
      await submitContactForm(formData);
      setSubmitStatus('success');
      setFormData({ name: '', email: '', phone: '', company: '', service: '', message: '' });
    } catch (error) {
      console.error(error);
      setSubmitStatus('error');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <>
      <Helmet>
        <title>Vardio | AI-Powered Growth Agency</title>
        <meta name="description" content={siteContent.home.hero.description} />
      </Helmet>

      <div className="cursor" id="cursor" />
      <div className="cursor-ring" id="cursorRing" />

      <div className="global-frost">
        <div className="luxury-mesh" />
        <div className="hero-grid" />
      </div>

      <nav id="navbar">
        <a href="#hero" className="nav-logo">
          <img src={logoImg} alt="Vardio" style={{ height: '36px', width: 'auto', borderRadius: '8px' }} />
          VARDIO
        </a>
        <ul className="nav-links">
          <li><a href="#system">System</a></li>
          <li><a href="#services">Services</a></li>
          <li><a href="#pricing">Pricing</a></li>
          <li><a href="#contact">Contact</a></li>
        </ul>
        <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
          <ThemeToggle />
          <a href="#contact" className="nav-cta">Book Call</a>
        </div>
        <button className="mobile-menu-toggle" onClick={() => setMobileMenuOpen(!mobileMenuOpen)}>
          {mobileMenuOpen ? <X size={24} /> : <List size={24} />}
        </button>
      </nav>

      {mobileMenuOpen && (
        <div className="mobile-nav-overlay" onClick={() => setMobileMenuOpen(false)}>
          <div className="mobile-nav-menu" onClick={e => e.stopPropagation()}>
            <a href="#system" onClick={() => setMobileMenuOpen(false)}>System</a>
            <a href="#services" onClick={() => setMobileMenuOpen(false)}>Services</a>
            <a href="#pricing" onClick={() => setMobileMenuOpen(false)}>Pricing</a>
            <a href="#contact" onClick={() => setMobileMenuOpen(false)}>Contact</a>
          </div>
        </div>
      )}

      <section id="hero">
        <div className="hero-container">
          <div className="hero-content">
            <div className="hero-eyebrow">{siteContent.home.hero.badge}</div>
            <h1 className="hero-headline">
              {siteContent.home.hero.title.map((line, i) => (
                <span className="line" key={i}><span>{line}</span></span>
              ))}
            </h1>
            <p className="hero-sub">{siteContent.home.hero.description}</p>
            <div className="hero-actions">
              <a href="#contact" className="btn-primary">{siteContent.home.hero.primaryCta}</a>
              <a href="#system" className="btn-ghost">{siteContent.home.hero.secondaryCta} <ArrowRight size={18} /></a>
            </div>
          </div>
        </div>
      </section>

      <section id="system" className="section-pad">
        <div className="section-inner">
          <div className="s-label reveal">{siteContent.home.system.title}</div>
          <div className="steps-grid">
            {siteContent.home.system.layers.map((layer, i) => (
              <div className="step-card" key={i}>
                <div className="step-num">{layer.step}</div>
                <div className="step-title">{layer.name}: <span>{layer.title}</span></div>
                <p className="step-body">{layer.description}</p>
                <div style={{ marginTop: '1.5rem', display: 'flex', flexWrap: 'wrap', gap: '0.5rem' }}>
                  {layer.tools.map((tool, j) => (
                    <span key={j} className="glass-badge" style={{ fontSize: '0.7rem', padding: '0.3rem 0.6rem' }}>{tool}</span>
                  ))}
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section id="compare" className="section-pad" style={{ background: 'var(--dark)' }}>
        <div className="section-inner">
          <div className="problem-grid">
            <div className="problem-text">
              <div className="s-label reveal">The Competitive Edge</div>
              <h2 className="reveal">Why Vardio Scales Faster.</h2>
              <div className="comparison-table" style={{ marginTop: '2rem' }}>
                <div style={{ border: '1px solid rgba(255,255,255,0.05)', borderRadius: '12px', overflow: 'hidden' }}>
                  <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', background: 'rgba(255,255,255,0.02)' }}>
                    <div style={{ padding: '1.5rem', borderRight: '1px solid rgba(255,255,255,0.05)', fontWeight: '700' }}>Traditional Agency</div>
                    <div style={{ padding: '1.5rem', fontWeight: '700', color: 'var(--green)' }}>Vardio AI</div>
                  </div>
                  {siteContent.home.comparison.traditional.map((item, i) => (
                    <div key={i} style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', borderTop: '1px solid rgba(255,255,255,0.05)' }}>
                      <div style={{ padding: '1rem 1.5rem', display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.85rem', opacity: 0.6 }}>
                        <WarningCircle size={16} color="#ef4444" /> {item}
                      </div>
                      <div style={{ padding: '1rem 1.5rem', display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.85rem' }}>
                        <CheckCircle size={16} color="var(--green)" /> {siteContent.home.comparison.vardio[i]}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
            <div className="problem-visual">
              {siteContent.home.audiences.map((audience, i) => (
                <InteractiveCard key={i} id={`ac${i}`} delay={i * 150} style={{ position: 'relative', top: 'auto', left: 'auto', marginBottom: '1rem', width: '100%' }}>
                  <div className="p-card-title">{audience.title}</div>
                  <div className="p-card-body">{audience.description}</div>
                  <div className="glass-badge" style={{ marginTop: '1rem', color: 'var(--green)' }}>Case: {audience.useCase}</div>
                </InteractiveCard>
              ))}
            </div>
          </div>
        </div>
      </section>

      <section id="services" className="section-pad">
        <div className="section-inner">
          <div className="services-header">
            <div>
              <div className="s-label reveal">Infrastructure</div>
              <h2 className="reveal">{siteContent.services.heading}</h2>
            </div>
            <p className="reveal">{siteContent.services.intro}</p>
          </div>
          <div className="service-grid">
            {siteContent.services.items.map((item, i) => (
              <div className="service-item" key={i}>
                <div className="service-bg-glow" />
                <div className="service-name">{item.title}</div>
                <div className="service-desc">{item.description}</div>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section id="pricing" className="section-pad">
        <div className="section-inner">
          <div className="pricing-header">
            <div className="s-label reveal" style={{ justifyContent: 'center' }}>Retainers</div>
            <h2 className="reveal">{siteContent.products.heading}</h2>
            <p className="reveal">{siteContent.products.intro}</p>
          </div>
          <div className="pricing-grid" style={{ gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))', gap: '1rem' }}>
            {siteContent.products.plans.map((plan, i) => (
              <div className={`price-card ${plan.badge ? 'featured' : ''}`} key={i} style={{ padding: '2rem 1.2rem' }}>
                {plan.badge && (
                  <div className="popular-badge" style={{ 
                    background: plan.badge === 'MOST POPULAR' ? 'var(--green)' : plan.badge === 'BEST VALUE' ? '#3b82f6' : '#8b5cf6',
                    fontSize: '0.5rem',
                    padding: '0.3rem 0.6rem'
                  }}>
                    {plan.badge}
                  </div>
                )}
                {plan.badge && <div className="price-card-glow" />}
                <div className="price-tier">{plan.label}</div>
                <div className="price-name" style={{ fontSize: '1rem' }}>{plan.title}</div>
                <div className="price-tagline" style={{ marginBottom: '1rem', fontSize: '0.7rem', minHeight: '2.5rem' }}>{plan.audience}</div>
                <div className="price-amount">
                  <span className="price-currency">₹</span><span className="price-num" style={{ fontSize: '1.8rem' }}>{plan.price}</span>
                  <span className="price-period">/mo</span>
                </div>
                <div style={{ margin: '0.8rem 0', padding: '0.8rem', background: 'rgba(16,185,129,0.05)', borderRadius: '8px', border: '1px solid rgba(16,185,129,0.1)' }}>
                  <div style={{ fontSize: '0.6rem', opacity: 0.7, textTransform: 'uppercase' }}>Results</div>
                  <div style={{ fontSize: '0.75rem', fontWeight: '700', color: 'var(--green)' }}>{plan.results}</div>
                </div>
                <div style={{ marginBottom: '1.5rem', fontSize: '0.65rem', opacity: 0.8 }}>
                  <span style={{ color: 'var(--green)', fontWeight: '600' }}>+ ₹{plan.setup} setup</span>
                  <span style={{ margin: '0 0.3rem', opacity: 0.3 }}>|</span>
                  <span>{plan.commitment} min</span>
                </div>
                <ul className="price-features" style={{ fontSize: '0.75rem', marginBottom: '1.5rem' }}>
                  {plan.bullets.map((bullet, j) => <li key={j} style={{ marginBottom: '0.4rem' }}>{bullet}</li>)}
                </ul>
                <a href="#contact" className="price-btn" style={{ padding: '0.7rem', fontSize: '0.8rem' }}>{plan.cta}</a>
              </div>
            ))}
          </div>

          <div className="reveal" style={{ marginTop: '6rem' }}>
            <div className="s-label">Add-ons</div>
            <h3 style={{ fontSize: '1.5rem', marginBottom: '2rem' }}>Optional Upgrades</h3>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '1.5rem' }}>
              {siteContent.products.addons.map((addon, i) => (
                <div key={i} className="glass-card" style={{ padding: '1.5rem', borderRadius: '12px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                  <div>
                    <div style={{ fontSize: '0.9rem', fontWeight: '600' }}>{addon.name}</div>
                    <div style={{ fontSize: '0.75rem', opacity: 0.6 }}>{addon.period === 'one-time' ? 'One-time' : 'per month'}</div>
                  </div>
                  <div style={{ color: 'var(--green)', fontWeight: '700' }}>₹{addon.price}</div>
                </div>
              ))}
            </div>
          </div>

          <div className="pricing-note reveal" style={{ marginTop: '4rem' }}>{siteContent.products.note}</div>
        </div>
      </section>

      <section id="faq" className="section-pad" style={{ background: 'var(--black)', borderTop: '1px solid rgba(255,255,255,0.05)' }}>
        <div className="section-inner">
          <div className="s-label reveal">FAQ</div>
          <h2 className="reveal" style={{ marginBottom: '4rem' }}>Common Questions</h2>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '3rem' }}>
            {siteContent.faq.map((item, i) => (
              <div key={i} className="reveal" style={{ transitionDelay: `${i * 0.1}s` }}>
                <h3 style={{ fontSize: '1.1rem', marginBottom: '1rem', color: 'var(--white)' }}>{item.question}</h3>
                <p style={{ color: 'var(--gray)', fontSize: '0.9rem', lineHeight: '1.6' }}>{item.answer}</p>
              </div>
            ))}
          </div>
          <div className="reveal" style={{ marginTop: '5rem', textAlign: 'center', padding: '3rem', background: 'var(--dark)', borderRadius: '12px', border: '1px solid rgba(16,185,129,0.1)' }}>
            <p style={{ marginBottom: '1.5rem' }}>Not sure which plan fits? Let&apos;s talk.</p>
            <a href="#contact" className="btn-primary">Book free 15-min consultation →</a>
          </div>
        </div>
      </section>

      <section id="contact" className="section-pad">
        <div className="section-inner">
          <div className="contact-layout">
            <div className="contact-text">
              <div className="s-label reveal-left">Contact</div>
              <h2 className="reveal-left">{siteContent.contact.heading}</h2>
              <p className="reveal-left">{siteContent.contact.intro}</p>
              <div className="contact-details">
                <a href={`https://wa.me/${siteContent.contact.direct.whatsapp.replace(/\D/g, '')}`} className="contact-item">
                  <ChatCircleDots size={24} color="var(--green)" />
                  <div><span className="ci-label">WhatsApp</span> {siteContent.contact.direct.whatsapp}</div>
                </a>
                <a href={`mailto:${siteContent.contact.direct.email}`} className="contact-item">
                  <Envelope size={24} color="var(--green)" />
                  <div><span className="ci-label">Email</span> {siteContent.contact.direct.email}</div>
                </a>
              </div>
            </div>
            <form className="contact-form reveal" onSubmit={handleSubmit}>
              <input type="text" name="name" className="form-input" placeholder="Your Name" value={formData.name} onChange={handleInputChange} required />
              <input type="email" name="email" className="form-input" placeholder="Email Address" value={formData.email} onChange={handleInputChange} required />
              <input type="tel" name="phone" className="form-input" placeholder="Phone Number" value={formData.phone} onChange={handleInputChange} required />
              <input type="text" name="company" className="form-input" placeholder="Business / Company Name" value={formData.company} onChange={handleInputChange} required />
              <select name="service" className="form-select" value={formData.service} onChange={handleInputChange} required>
                <option value="" disabled>Select Plan</option>
                {siteContent.products.plans.map((p, i) => <option key={i} value={p.label}>{p.title}</option>)}
              </select>
              <textarea name="message" className="form-textarea" placeholder="Tell us about your brand goals..." value={formData.message} onChange={handleInputChange} required />
              <MorphingSubmitButton loading={isSubmitting} submitResult={submitStatus === 'submitting' ? null : (submitStatus === 'idle' ? null : submitStatus)} onResetResult={() => setSubmitStatus('idle')} disabled={isSubmitting || submitStatus === 'success'} />
            </form>
          </div>
        </div>
      </section>

      <footer>
        <div className="footer-brand">VARDIO</div>
        <div className="footer-links">
          <a href="#system">System</a>
          <a href="#services">Services</a>
          <a href="#pricing">Pricing</a>
          <a href="mailto:vardioindia@gmail.com">vardioindia@gmail.com</a>
        </div>
        <div className="footer-copy">© {new Date().getFullYear()} Vardio. All rights reserved.</div>
      </footer>
      <WhatsAppFloat />
    </>
  );
};

export default Home;