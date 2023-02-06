generate:
	tuist fetch
	tuist generate

clean:
	rm -rf **/*.xcodeproj
	rm -rf **/*.xcworkspace
