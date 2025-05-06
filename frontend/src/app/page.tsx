import { Base, Header, Button, Text, Stack, Cluster } from 'smarthr-ui'
import Link from 'next/link'

export default function Home() {
  return (
    <Base>
      <div className="flex flex-col min-h-screen">
        <main className="p-8 max-w-5xl mx-auto flex-grow">
          <div className="py-16 text-center">
            <Text weight="bold" size="XXL" className="mb-4">
              あなたの生活をもっと効率的に
            </Text>
            <Text className="mb-8">
              Life Managementは、日々のタスク管理や目標設定をサポートし、あなたの生活をより豊かにします。
            </Text>
            <Cluster gap="M" justify="center">
              <Link href="/dashboard">
                <Button variant="primary">
                  始める
                </Button>
              </Link>
              <Link href="/about">
                <Button>
                  詳細を見る
                </Button>
              </Link>
            </Cluster>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 py-8">
            <div className="p-6 border rounded-md">
              <Stack gap="S">
                <Text weight="bold" size="L">
                  タスク管理
                </Text>
                <Text>
                  日々のタスクを簡単に管理し、優先順位をつけて効率的に処理できます。
                </Text>
              </Stack>
            </div>
            <div className="p-6 border rounded-md">
              <Stack gap="S">
                <Text weight="bold" size="L">
                  目標設定
                </Text>
                <Text>
                  短期・長期の目標を設定し、進捗を追跡することで達成感を味わえます。
                </Text>
              </Stack>
            </div>
            <div className="p-6 border rounded-md">
              <Stack gap="S">
                <Text weight="bold" size="L">
                  習慣トラッキング
                </Text>
                <Text>
                  良い習慣を形成し、日々の成長を記録できます。
                </Text>
              </Stack>
            </div>
          </div>
        </main>

        <footer className="bg-gray-100 p-8 text-center mt-auto">
          <Text size="S">© 2024 Life Management. All rights reserved.</Text>
        </footer>
      </div>
    </Base>
  )
}
