document.addEventListener("DOMContentLoaded", () => {
    if (typeof Tone === 'undefined' || !customElements.get('midi-player')) {
        console.error("Required dependencies not loaded");
        return;
    }

    const midiMap = {
        "1": 60, "2": 62, "3": 64, "4": 65, "5": 67, "6": 69, "7": 71, 
        "q": 48, "w": 50, "e": 52, "r": 53, "t": 55, "y": 57, "u": 59,
        "!": 72, "@": 74, "#": 76, "$": 77, "%": 79, "^": 81, "&": 83,
        "/": 1, "\\": -1, 
        ":": "louder", ";": "softer", 
        "[": "repeat_start", "]": "repeat_end",
        "(": "long_bar", ")": "short_bar", "_": "double_bar",
		"J": "half_duration"
    };

    function parseNotation(input) {
        const cleanedInput = input.trim().replace(/\s+/g, ' ');
        
        if (!cleanedInput) {
            console.warn("Input kosong atau hanya berisi whitespace");
            return [];
        }

        const notes = cleanedInput.split(' ');
        const midiData = [];
        let currentOctaveShift = 0;
        let velocity = 64;
        let repeatStartIndex = null;
        let svgElements = [];
        let previousX = 0;
        let inLegato = false;
        let legatoStartX = 0;
        let customLegatoActive = false;
        let legatoType = '';

        const baseY = 60;
        const noteSpacing = 30;

        notes.forEach((note, index) => {
            if (!note) return;

            const validChars = /^[1-7qwertyu!@#$%^&\/\\:;\(\)_\.\[\]fghzxcJ]+$/;
            if (!validChars.test(note)) {
                console.warn(`Karakter tidak valid ditemukan di notasi: ${note}`);
                return;
            }

            if (note.startsWith('f') || note.startsWith('g') || note.startsWith('h')) {
                legatoType = note[0];
                note = note.substring(1);
                inLegato = true;
            }
            
            if (note === 'z') {
                customLegatoActive = true;
                legatoStartX = previousX;
                return;
            }
            
            if (note === 'c') {
                customLegatoActive = false;
                return;
            }

            let cleanNote = note.replace(/[^1-7qwertyu!@#$%^&*\.J]/g, '');
            if (cleanNote === "") return;

            cleanNote.split('').forEach((char) => {
                if (midiMap[char] !== undefined) {
                    const pitch = midiMap[char];

                    if (typeof pitch === 'number') {
                        if (pitch === 1 || pitch === -1) {
                            currentOctaveShift += pitch * 12;
                        } else {
                            const adjustedPitch = pitch + currentOctaveShift;
							const hasHalfDuration = note.includes('J');
                            const duration = note.includes('.') ? 1.5 :
							hasHalfDuration ? 0.5 : 1;

                            if (adjustedPitch < 0 || adjustedPitch > 127) {
                                console.warn(`Pitch ${adjustedPitch} di luar range MIDI valid`);
                                return;
                            }

                            midiData.push({ pitch: adjustedPitch, duration, velocity });

                            const xOffset = previousX + noteSpacing;
							
							const fontSize = hasHalfDuration ? "12" : "16";
							svgElements.push(`<text x="${xOffset}" y="${baseY}" font-size="${fontSize}" text-anchor="middle" fill="black">${char}</text>`);
                            
                            if (note.includes('.')) {
                                svgElements.push(`<circle cx="${xOffset + 8}" cy="${baseY - 4}" r="2" fill="black"/>`);
                            }

                            if (inLegato && midiData.length > 1) {
                                const lineStyle = {
                                    'f': 'stroke-width="2"',
                                    'g': 'stroke-width="1.5" stroke-dasharray="5,2"',
                                    'h': 'stroke-width="1" stroke-dasharray="2,2"'
                                }[legatoType];

                                svgElements.push(`<line x1="${previousX}" y1="${baseY - 20}" x2="${xOffset}" y2="${baseY - 20}" stroke="black" ${lineStyle} />`);
                            }

                            if (customLegatoActive && note === 'x') {
                                svgElements.push(`<line x1="${legatoStartX}" y1="${baseY - 20}" x2="${xOffset}" y2="${baseY - 20}" stroke="black" stroke-width="1" />`);
                                legatoStartX = xOffset;
                            }

                            previousX = xOffset;
                        }
                    } else if (pitch === "louder") {
                        velocity = Math.min(velocity + 10, 127);
                    } else if (pitch === "softer") {
                        velocity = Math.max(velocity - 10, 0);
                    } else if (pitch === "repeat_start") {
                        repeatStartIndex = midiData.length;
                    } else if (pitch === "repeat_end" && repeatStartIndex !== null) {
                        const repeatSection = midiData.slice(repeatStartIndex);
                        midiData.push(...repeatSection);
                    }
                }
            });

            if (note === '(') {
                svgElements.push(`<line x1="${previousX + 15}" y1="${baseY - 30}" x2="${previousX + 15}" y2="${baseY + 20}" stroke="black" stroke-width="2" />`);
            } else if (note === ')') {
                svgElements.push(`<line x1="${previousX + 15}" y1="${baseY - 20}" x2="${previousX + 15}" y2="${baseY + 10}" stroke="black" stroke-width="1" />`);
            } else if (note === '_') {
                svgElements.push(`<line x1="${previousX + 13}" y1="${baseY - 20}" x2="${previousX + 13}" y2="${baseY + 10}" stroke="black" stroke-width="1" />`);
                svgElements.push(`<line x1="${previousX + 17}" y1="${baseY - 20}" x2="${previousX + 17}" y2="${baseY + 10}" stroke="black" stroke-width="1" />`);
            }

            inLegato = false;
        });

        if (svgElements.length > 0) {
            document.getElementById("svgDisplay").innerHTML = 
                `<svg xmlns='http://www.w3.org/2000/svg' width='${previousX + 50}' height='100' style='border:1px solid black;'>
                    ${svgElements.join('')}
                </svg>`;
        }

        return midiData;
    }

    window.convertToMIDI = function () {
        const input = document.getElementById("notationInput").value;
        const midiData = parseNotation(input);

        const header = [0x4d, 0x54, 0x68, 0x64, 0x00, 0x00, 0x00, 0x06, 0x00, 0x01, 0x00, 0x01, 0x00, 0x60];
        const track = [0x4d, 0x54, 0x72, 0x6b];
        let trackData = [];

        midiData.forEach((note) => {
            trackData.push(0x00, 0x90, note.pitch, note.velocity); // Note On
            trackData.push(0x60 * note.duration, 0x80, note.pitch, note.velocity); // Note Off
        });

        const trackLength = trackData.length;
        track.push((trackLength >> 24) & 0xFF, (trackLength >> 16) & 0xFF, (trackLength >> 8) & 0xFF, trackLength & 0xFF);
        const midiFile = new Uint8Array([...header, ...track, ...trackData]);

        const blob = new Blob([midiFile], { type: "audio/midi" });
        const url = URL.createObjectURL(blob);

        const player = document.getElementById("midiPlayer");
        player.src = url;
        
        const visualizer = document.getElementById("myStaffVisualizer");
        visualizer.src = url;

        const downloadLink = document.getElementById("downloadMidi");
        downloadLink.href = url;
        downloadLink.classList.remove("disabled");
        downloadLink.classList.add("enabled");
    }
});