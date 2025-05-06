'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';

export function Header() {
  const pathname = usePathname();

  // ナビゲーションリンクの配列
  const navLinks = [
    { name: 'ホーム', href: '/' },
    { name: 'タスク一覧', href: '/task-list' },
  ];

  return (
    <header className="bg-[#20c4cc] shadow-sm">
      <div className="container mx-auto py-3">
        <div className="flex justify-between items-center">
          <Link
            href="/"
            className="font-bold text-xl text-white"
          >
            Life Management
          </Link>

          <nav>
            <ul className="flex space-x-6">
              {navLinks.map((link) => {
                const isActive = pathname === link.href;
                return (
                  <li key={link.href}>
                    <Link
                      href={link.href}
                      className={`${
                        isActive
                          ? 'text-white font-semibold'
                          : 'text-gray-100 hover:text-white'
                      } transition-colors`}
                    >
                      {link.name}
                    </Link>
                  </li>
                );
              })}
            </ul>
          </nav>
        </div>
      </div>
    </header>
  );
} 