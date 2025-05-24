export function MainContainer({ children }: { children: React.ReactNode }) {
  return (
    <div className="container mx-auto my-4 w-full">
      {children}
    </div>
  );
}