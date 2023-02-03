generate:
	tuist generate
	tuist fetch

clean:
	rm -rf **/*.xcodeproj
	rm -rf **/*.xcworkspace
