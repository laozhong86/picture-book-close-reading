# 绘本精读 · Picture Book Close Reading

一个 [Claude Code](https://claude.com/claude-code) skill，辅助父母对儿童绘本做有方法、可落地的精读。

父母只需提供一个绘本名称或封面照片，即可自动产出一张 **A4 打印就绪**的精读指引——包含 PEER/CROWD 提问脚本、Chambers 四问、Bloom 分层提问、视觉素养训练点、反模式提醒，以及可直接复制到 AI 图像工具的延伸活动生图提示词。

## 一键安装

```bash
npx -y skills add laozhong86/picture-book-close-reading -g -y
```

重启 Claude Code，然后在对话里说 "帮我精读《任意绘本》" 即可触发。

## 它做什么

1. **首次使用**：一次性建立孩子的阅读档案（昵称、年龄、性格、兴趣、父母期待），持久化到 `data/child_profile.json`，之后每次讲绘本自动适配，不用再问。
2. **每本新书**：父母发来书名（或封面照）→ skill 自动搜索绘本背景 → 若重名列候选让父母选 → 结合孩子档案生成 A4 一页纸指引。
3. **输出五步闸门**：Markdown 预览 → 父母确认 → 写 HTML → 字数/占位符/版块自检 → 追加阅读历史。

## 方法论基础

- **对话式阅读** Dialogic Reading（Whitehurst, 1988，唯一有大量 RCT 证据支持的亲子共读方法）
- **Aidan Chambers 告诉我四问**
- **Bloom 分层提问**（记忆→理解→分析→评价→创造）
- **视觉素养** Visual Literacy（构图/色彩/视角/留白/图文反讽）
- **三种连接** Text-to-Self / Text-to-Text / Text-to-World

详见 [`references/方法论.md`](references/方法论.md)。

## 文件结构

```
picture-book-close-reading/
├── SKILL.md                       # 主工作流：三阶段 + 五步闸门
├── references/
│   ├── 方法论.md                   # 五大方法论完整细节
│   ├── 年龄适配.md                 # 年龄 × 性格 × 兴趣 × 父母期待矩阵
│   └── 反模式.md                   # 通用 + 年龄特定 + 生图反模式
├── assets/
│   ├── child_profile_schema.json  # 孩子档案 JSON Schema
│   └── a4_template.html           # A4 打印模板
└── test-prompts.json              # 3 个测试场景
```

运行时会自动创建：
- `data/child_profile.json` — 孩子档案（本地持久化）
- `output/<书名>_<日期>.html` — 生成的 A4 指引

## 适用年龄

0–8+ 岁。见 [`references/年龄适配.md`](references/年龄适配.md) 的年龄 × 性格矩阵。

## 反馈

Issue 和 PR 欢迎。[Issues →](https://github.com/laozhong86/picture-book-close-reading/issues)

## License

MIT
