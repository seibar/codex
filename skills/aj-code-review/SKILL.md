---
name: aj-code-review
description: "Review PRs, branches, diffs, commits, or uncommitted changes using AJ's standard contract. Report only security and functional defects graded CRITICAL, HIGH, or MEDIUM; exclude style, nits, and ordinary test-coverage feedback."
---

# AJ Code Review

Apply AJ's review contract to the target named by the user or calling workflow.
This skill defines the review dimensions; the caller may define the target and
delivery format. When invoked directly, report findings as Markdown in the
conversation.

Review both the change and what it claims to do. For a pull request, consider
its description; for a branch, commit, diff, or working tree, infer intent from
the available request and code. Confirm every finding against the actual source
before reporting it. Do not report a finding that cannot be defended
line-by-line.

## Flag

### Security

- Injection vulnerabilities, including SQL, command, LDAP, path traversal, and
  template injection.
- Missing authentication or authorization, broken ownership checks, and
  privilege-escalation paths.
- Secrets or credentials committed in code or configuration.
- Unvalidated or unsanitized input at trust boundaries, such as API endpoints,
  file uploads, and environment values interpolated into shell commands.
- Insecure direct object references.
- Sensitive data exposed through logs, errors, responses, or unencrypted
  storage.
- Known-vulnerable or suspiciously named dependency additions.
- SSRF and open-redirect risks.

### Functional

- Logic errors or incorrect conditions that produce wrong results.
- Race conditions and unsafe shared mutable state.
- Missing or incorrect error handling that causes silent failure or data
  corruption.
- Broken contracts, including incorrect signatures, return types, and violated
  invariants.
- Data-integrity defects such as missing transactions, incorrect upserts, and
  lost updates.
- Off-by-one and boundary errors.
- Null or undefined dereferences that cause crashes.
- Missing handling for realistic edge cases such as empty collections, zero
  values, and concurrent requests.
- Business-logic errors relative to the stated intent of the change.

## Do not flag

- Style, formatting, or naming.
- Refactoring suggestions.
- Test-coverage gaps.
- Comments or documentation.
- Performance unless the change introduces a severe regression, such as an
  N+1 query over an unbounded collection.
- Anything that is merely a nit.

Do not pad a clean review with lesser findings.

## Severity

- **CRITICAL**: Exploitable now, causes data loss, or threatens patient safety.
- **HIGH**: Likely to cause a production incident or security breach.
- **MEDIUM**: Causes incorrect behavior under realistic conditions.

## Report

- Start with findings; do not summarize what the change does.
- Put one finding on each line: severity, `path/to/file:line`, then a concise
  description of the defect and its consequence.
- Group findings under **SECURITY** and **FUNCTIONAL**, most severe first.
- If the change is clean, write `No issues found.` explicitly.
- Use Markdown by default. A calling workflow may override the delivery format.
