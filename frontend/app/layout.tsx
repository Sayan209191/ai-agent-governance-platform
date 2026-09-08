import "./globals.css";
import type { ReactNode } from "react";

export const metadata = {
  title: "AI Agent Governance Platform",
  description: "Admin dashboard for agents, approvals, and audit trail",
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body className="bg-slate-50 text-slate-900">
        <nav className="border-b bg-white px-6 py-4 flex gap-6">
          <a href="/" className="font-semibold">Governance</a>
          <a href="/agents">Agents</a>
          <a href="/approvals">Approvals</a>
          <a href="/audit">Audit</a>
        </nav>
        <main className="p-6">{children}</main>
      </body>
    </html>
  );
}
