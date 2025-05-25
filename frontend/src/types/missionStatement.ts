export type MissionStatement = {
  id: number
  content: string
  created_at: string
  updated_at: string
}

export type CreateMissionStatementPayload = {
  content: string
}

export type MissionStatementResponse = {
  data: MissionStatement
}