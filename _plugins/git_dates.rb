# Dates each post from git history instead of its filename:
#   page.date             - when the file was first committed (follows renames)
#   page.last_modified_at - when it was last committed, or its mtime if it has uncommitted edits
# A post that has never been committed uses its mtime for both.
# Commits whose message contains [no-date] don't count as updates (use it for housekeeping).
# Set `created: YYYY-MM-DD` in a post's front matter to override the created date.
require "open3"
require "time"

module GitDates
  class Generator < Jekyll::Generator
    priority :highest

    def generate(site)
      site.posts.docs.each do |post|
        mtime = File.mtime(post.path)
        # One "date<TAB>subject" line per commit, newest first.
        history = git(site.source, "log", "--follow", "--format=%aI%x09%s", "--", post.path)
                  .lines.map { |line| line.chomp.split("\t", 2) }.reject { |date, _| date.to_s.empty? }
        edits = history.reject { |_, subject| subject.to_s.include?("[no-date]") }

        created = history.empty? ? mtime : Time.iso8601(history.last[0])
        updated = edits.empty? ? created : Time.iso8601(edits.first[0])
        updated = mtime unless git(site.source, "status", "--porcelain", "--", post.path).strip.empty?
        created = Jekyll::Utils.parse_date(post.data["created"].to_s) if post.data["created"]

        post.data["date"] = created
        post.data["last_modified_at"] = updated
      end
      site.posts.docs.sort!
    end

    private

    def git(dir, *args)
      out, status = Open3.capture2("git", *args, chdir: dir)
      status.success? ? out : ""
    rescue SystemCallError
      ""
    end
  end
end
