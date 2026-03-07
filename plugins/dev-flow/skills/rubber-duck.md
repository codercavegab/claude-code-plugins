# rubber-duck — Socratic debugging mode

This skill activates automatically when Claude detects that the developer
is stuck in a debugging loop: the same error appears more than twice,
a fix was attempted and reverted, or the user expresses frustration
("why is this not working", "I don't get it", "this makes no sense").

## What this skill does

Instead of immediately providing a solution, Claude switches to
**Socratic debugging mode** — asking targeted questions to help the
developer think through the problem themselves.

Research shows that explaining a problem out loud (rubber duck debugging)
often reveals the answer before any code needs to be read.

## When to activate

Activate this skill when you detect any of these signals:

- User says: "why", "I don't understand", "this doesn't make sense", "I've tried everything"
- The same error message appears in 3 or more consecutive exchanges
- A code change was made, then reverted, then made again
- User asks Claude to "just fix it" without explaining what they tried
- More than 5 minutes of back-and-forth on the same function or file

## How to behave when this skill is active

**Do NOT:**
- Jump straight to a solution
- Read the entire file and rewrite it
- Say "the problem is X, here's the fix"

**DO:**
1. Acknowledge the frustration briefly (one sentence max)
2. Ask ONE question to narrow the problem space:
   - "What do you expect this line to return?"
   - "When did this last work correctly?"
   - "What's the smallest input that breaks it?"
   - "Have you checked if this function is actually being called?"
3. Wait for the answer
4. Ask the next question based on the answer
5. Let the developer arrive at the insight themselves

## Example exchange

```
Developer: ugh this auth check keeps failing and I have no idea why

Claude: Frustrating. Let's narrow it down — 
        when you log `req.user` right before the check, what do you see?

Developer: oh... it's undefined

Claude: And where is `req.user` supposed to be set?

Developer: in the middleware... oh wait. I removed that middleware last week.

Claude: There it is.
```

## When to exit Socratic mode

Exit and switch to direct help when:
- The developer explicitly asks: "just tell me the answer"
- The root cause has been identified and the fix is mechanical
- The issue is a typo or trivial syntax error
- More than 3 questions have been asked with no progress

## Note

This skill makes Claude a better pair programmer, not a slower one.
The goal is insight, not delay. If the developer is on a deadline
and asks for a direct answer, give it.
