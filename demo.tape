# demo.tape — hero recording for the README
#
# Records the scaffold inner loop: create a project, run it, change a file,
# watch it redeploy.
#
# Requires https://github.com/charmbracelet/vhs
#
#   vhs demo.tape
#
# PRECONDITIONS (matter more than the tape itself)
#
#   1. `lgs` on PATH: `cargo install --path .`
#   2. A warm cache. The first `lgs run` in a fresh environment compiles the
#      LEZ toolchain from source and takes minutes, which will blow the 45s
#      budget and time out the Sleep values below. Run the whole flow once by
#      hand first so the LEZ checkout, circuits release, and sequencer binary
#      are already built.
#   3. No sequencer on 127.0.0.1:3040: `lgs localnet stop`.
#   4. A scratch directory. The Hide block below creates and cleans one.
#
# If the recording overruns, raise the Sleep values rather than trimming steps.
# A GIF that cuts off mid-deploy is worse than a longer one.

Output demo.gif
Output demo.mp4

Require lgs

Set Shell "bash"
Set FontSize 22
Set Width 1200
Set Height 600
Set Padding 20
Set TypingSpeed 60ms

# --- off-camera setup -------------------------------------------------------
Hide
Type "cd $(mktemp -d) && clear"
Enter
Sleep 1s
Show

# --- create -----------------------------------------------------------------
Type "lgs new my-app --template lez-framework"
Enter
Sleep 4s

Type "cd my-app"
Enter
Sleep 1s

# --- the inner loop ---------------------------------------------------------
# build -> IDL -> localnet -> topup -> deploy, in one command.
Type "lgs run"
Enter
Sleep 25s

# --- the payoff -------------------------------------------------------------
# A second run reuses the running localnet and skips deploy when nothing
# changed. This is the part that sells the tool.
Type "lgs run"
Enter
Sleep 6s

Sleep 2s

# --- teardown ---------------------------------------------------------------
Hide
Type "lgs localnet stop"
Enter
Sleep 3s
Show
