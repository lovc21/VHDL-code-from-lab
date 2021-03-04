	component vio is
		port (
			source : out std_logic_vector(3 downto 0)   -- source
		);
	end component vio;

	u0 : component vio
		port map (
			source => CONNECTED_TO_source  -- sources.source
		);

