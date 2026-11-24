import { expect, test } from 'claude-code/testing'

import { problems } from './colors'

test('Desktop paints the theme', async () => {
  expect(problems.filter(line => line.startsWith("Desktop won't paint"))).toEqual([])
})
