local ok_status, windex = pcall(require, "windex")

if not ok_status then
  return
end

windex.setup()
