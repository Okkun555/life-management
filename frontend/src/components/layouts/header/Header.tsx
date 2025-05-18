"use client";

import { usePathname } from "next/navigation";
import Link from "next/link";
import styled from "styled-components";

export function Header() {
  const pathname = usePathname();

  // ナビゲーションリンクの配列
  const navLinks = [
    { name: "ホーム", href: "/" },
    { name: "タスク一覧", href: "/task-list" },
  ];

  return (
    <StyledHeader>
      <HeaderContent>
        <Logo href="/">
          Life Management
        </Logo>
        
        <Nav>
          <NavList>
            {navLinks.map((link) => {
              const isActive = pathname === link.href;
              return (
                <NavItem key={link.href}>
                  <NavLink 
                    href={link.href}
                    $isActive={isActive}
                  >
                    {link.name}
                  </NavLink>
                </NavItem>
              );
            })}
          </NavList>
        </Nav>
      </HeaderContent>
    </StyledHeader>
  );
}

const StyledHeader = styled.header`
  background-color: #20c4cc;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
  width: 100%;
`;

const HeaderContent = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  padding: 0.75rem 1rem;
`;

const Logo = styled(Link)`
  color: white;
  font-size: 1.5rem;
  font-weight: bold;
  text-decoration: none;
  transition: opacity 0.2s ease;
  margin-left: 1rem;
  
  &:hover {
    opacity: 0.9;
  }
`;

const Nav = styled.nav``;

const NavList = styled.ul`
  display: flex;
  gap: 1.5rem;
  list-style: none;
  margin: 0;
  padding: 0;
  margin-right: 1rem;
`;

const NavItem = styled.li``;

interface NavLinkProps {
  $isActive?: boolean;
}

const NavLink = styled(Link)<NavLinkProps>`
  color: ${({ $isActive }) => ($isActive ? "white" : "rgba(255, 255, 255, 0.9)")};
  font-weight: ${({ $isActive }) => ($isActive ? "bold" : "normal")};
  text-decoration: none;
  padding: 0.5rem 0;
  position: relative;
  
  &:hover, &:focus {
    color: white;
  }
  
  ${({ $isActive }) => $isActive && `
    &:after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 2px;
      background-color: white;
    }
  `}
`;